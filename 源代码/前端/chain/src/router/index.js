import Vue from 'vue';
import vueRouter from 'vue-router'
Vue.use(vueRouter);

 import homepage from './page/homepage'
 import regist from './page/regist'
 import enterprise from './page/enterprise'
 import logistics from './page/logistics'
 import notFound from './page/notFound'
 import bank from './page/bank'
 import insurance from './page/insurance'

 /* enterprise children */
 import enterpriseContract from './page/Econtract'
 import enterpriseInsurance from './page/Einsurance'
 import enterpriseInventory from './page/Einventory'
 import enterpriseLogistics from './page/Elogistics'
 import enterpriseTokenchange from './page/Etokenchange'
 import enterpriseTokenpay from './page/Etokenpay'

 /* logistics children */
 import logisticsInsurance from './page/Linsurance'
 import logisticsLogistics from './page/Llogistics'
 import logisticsTokenchange from './page/Ltokenchange'
 import logisticsTokenpay from './page/Ltokenpay'

 /* logistics children */
 import insuranceInsurance from './page/Iinsurance'
 import insuranceBid from './page/Ibid'
 import insuranceTokenchange from './page/Itokenchange'
 import insuranceTokenpay from './page/Itokenpay'

 /* bank children */
 import bankCredit from './page/Bcredit'
 import bankGuarantee from './page/Bguarantee'
 import bankToken from './page/Btoken'

  let router =   new vueRouter({
         mode:'history',
         routes:[
             {
               path:'/homepage',
               component: homepage,
               name:'homepage'
             },
             {
                path:'/regist',
                component: regist,
                name:'regist',
                meta:{
                    title:'注册页面'
                }
             }
             ,
             /* enterprise */
             {
                path:'/enterprise',
                component: enterprise,
                name:'enterprise'
             }
             ,
            /* enterprise child pages */

            {
               path:'/enterprise/contract',
               component: enterpriseContract,
               name:'enterpriseContract'
            },
             {
               path:'/enterprise/insurance',
               component: enterpriseInsurance,
               name:'enterpriseInsurance'
            },

            {
               path:'/enterprise/inventory',
               component: enterpriseInventory,
               name:'enterpriseInventory'
            },

            {
               path:'/enterprise/logistics',
               component: enterpriseLogistics,
               name:'enterpriseLogistics'
            },

            {
               path:'/enterprise/tokenchange',
               component: enterpriseTokenchange,
               name:'enterpriseTokenchange'
            },

            {
               path:'/enterprise/tokenpay',
               component: enterpriseTokenpay,
               name:'enterpriseTokenpay'
            },

            /* logistics */
            {
               path:'/logistics',
               component: logistics,
               name:'logistics'
            },
            /* logistics child pages */
             {
               path:'/logistics/insurance',
               component: logisticsInsurance,
               name:'logisticsInsurance'
            },

            {
               path:'/logistics/logistics',
               component: logisticsLogistics,
               name:'logisticsLogistics'
            },

            {
               path:'/logistics/tokenchange',
               component: logisticsTokenchange,
               name:'logisticsTokenchange'
            },
            {
               path:'/logistics/tokenpay',
               component: logisticsTokenpay,
               name:'logisticsTokenpay'
            },

            /* insurance */            
             {
               path:'/insurance',
               component: insurance,
               name:'insurance'
            }
            ,

            /* insurance chils pages */
            {
               path:'/insurance/insurance',
               component: insuranceInsurance,
               name:'insuranceInsurance'
            },

            {
               path:'/insurance/bid',
               component: insuranceBid,
               name:'insuranceBid'
            },

            {
               path:'/insurance/tokenchange',
               component: insuranceTokenchange,
               name:'insuranceTokenchange'
            },
            {
               path:'/insurance/tokenpay',
               component: insuranceTokenpay,
               name:'insuranceTokenpay'
            },
            /* bank */
            {
               path:'/bank',
               component: bank,
               name:'bank'
            },
            /* bank child pages */
            {
               path:'/bank/credit',
               component: bankCredit,
               name:'bankCredit'
            },

            {
               path:'/bank/guarantee',
               component: bankGuarantee,
               name:'bankGuarantee'
            },

            {
               path:'/bank/token',
               component: bankToken,
               name:'bankToken'
            },

             {
                path:'*',
                component: notFound,
                name:'notFound'
             }
             
             
         ]
     })

     export default  router