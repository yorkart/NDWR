﻿//-----------------------------------------------------------------------------------------
//   <copyright company="同程网" file="NHVEntityValidateInterceptor.cs">
//      所属项目：RemoteService
//      创 建 人：王跃
//      创建日期：2012-8-9 8:17:36
//      用    途：请一定在此描述用途
//
//      更新记录:
//
//   </copyright> 
//-----------------------------------------------------------------------------------------

namespace RemoteService {
    using System.Collections;
    using System.Collections.Generic;
    using NDWR;
    using NDWR.MethodInterceptor;
    using NDWR.ServiceStruct;
    using NHibernate.Validator.Engine;

    /// <summary>
    /// NHVEntityValidateInterceptor 概要
    /// </summary>
    public class NHVEntityValidateInterceptor : Interceptor {
        public void Init() {
        }

        public object Intercept(MehtodInvocation methodInvoke) {
            IList<ServiceMethodParam> paramList = methodInvoke.Method.Params;
            int index = 0;
            foreach (ServiceMethodParam param in paramList) {
                if (!param.IsSimplyType) {
                    object retValue = methodInvoke.InvokeInfo.TargetParams[index];
                    InvalidValue[] msgs = NHVHelper.Instance.Validate(retValue);
                    //if (!NHVHelper.Instance.IsValid(retValue)) {
                    if (msgs.Length > 0) {
                        foreach (InvalidValue iv in msgs) {
                            methodInvoke.InvokeInfo.SystemErrors.Add(
                                new NDWR.RspError(iv.PropertyName, iv.Message));
                        }
                        return null;
                    }
                }
                index++;
            }
            return methodInvoke.Invoke();
        }

        public void Destroy() {
        }
    }
}