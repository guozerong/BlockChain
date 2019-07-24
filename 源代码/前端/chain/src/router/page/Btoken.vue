<template>
    <div class="middle" :style="backgroundDiv">
          <div id="u1" class="text" style="display:none; visibility: hidden">
          <p><span></span></p>
        </div>
        
         <div id="u2" class="ax_default label">
        <div id="u2_div" class=""></div>
        <!-- welcome -->
        <div id="u3" class="text" style="position: absolute;margin-top:0px;margin-left:19px;">
          <p id="wel"><span>{{ welcome }}</span></p>
        </div>

        <div id="token" style="position: absolute;margin-top:70px;margin-left:940px;">
            <p id="quit"><span>Token: </span><span>{{token}}</span></p>
        </div>
        <div id="ux" @click="goto('/homepage'),$router.go(0)" style="position: absolute;margin-top:70px;margin-left:1140px;">
          <p id="quit"><span>退出</span></p>
        </div>
        </div>
         <div class="menu" style="z-index:9999; position: absolute; margin-top:70px; margin-left:19px; ">
         <bankmenu></bankmenu>
         </div>
        <!-- white background -->
         <div id="bkg" style="position: absolute;  margin-top:123px; margin-left:19px; ">
                <ul id="submenu">
                <li id="dark" class="down">
                     编号 
                </li>
                <li id="light" class="down">
                     企业名称
                </li>
                 <li id="dark" class="down">
                     兑付金额
                </li>
                 
                 <li id="light" class="down">
                     申请时间
                </li>
                 <li id="dark" class="down">
                     兑付状态
                </li>
                 
                 <li id="light" class="down">
                     状态更新时间
                </li>
                
                 <li id="do" class="down">
                     操作 
                </li>

                    </ul>
                <!-- data table -->
                <div style="margin-left:25px">
                    <table style="float:left;border-collapse: collapse;" >
                        <tr  v-for="user in users">
                <td id="x" >{{user.id}}</td>
                <td id="x" >{{user.name}}</td>
                <td id="x" >{{user.money}}</td>
                <td id="x" >{{user.mapplytime}}</td>
                <td id="xcondition" >{{user.condition}}</td>
                <td id="x" >{{user.conditiontime}}</td>
                <td type="button" id="xdo" v-on:click="accept" v-if="user.condition ==='待兑付'" >
                    确认兑付
                </td>
                <td id="xdo" v-else> 
                </td>
                <td type="button" id="xdo"  v-if="user.condition==='待兑付'" v-on:click="reject">
                    拒绝兑付
                </td>
                <td id="xdo" v-else>
                </td>

            </tr>
                    </table>
                </div>
         </div>
    </div>

         
</template>
<script>
import bankmenu from "./component/bankMenu"
export default {
    inject:['reload'],
    data(){
         return{
            welcome: '欢迎来到银行服务平台',
            backgroundDiv: {
            backgroundImage: 'url(' + require('./pic/bank.jpg') + ')'

        },
        token:'1000Token',
         users: [
                    {"id":1, "name":"xx1企业", "money":"100Token","mapplytime":"2019-06-01","condition":"已拒绝","conditiontime":"2019-06-02"},
                    {"id":1, "name":"xx1企业", "money":"120Token","mapplytime":"2019-06-01","condition":"待兑付","conditiontime":"2019-06-02"}
                    ]
        }
    },
    components:{ bankmenu:bankmenu },
        methods:{
    someThing(a){
          console.log(a);
    },
    goto(url,index){
          this.$router.push(url);
          console.log(this.$route); 
          this.activeIndex =index;
    }
    }
}
</script>
<style>
   #wel{color:#97CC78;
font-size:32px;
}
#bkg{
background: rgba(255,255,255, 0.5);
width: 1159px;
height: 567px;
}

#quit{
    font-size:18px;
    color: white;
}
#dark{
    background-color:#FCFDF7;
    text-align:center;
    width:132px;
    height:43px;
    border:none;
    line-height: 43px;
    display:inline-block;

}
#light{
    background-color:#EDD3B2;
    text-align:center;
    width:132px;
    height:43px;
    border:none;
    line-height: 43px;
    display:inline-block;
}
#do{
    background-color:#FCFDF7;
    text-align:center;
    width:182px;
    height:43px;
    border:none;
    line-height: 43px;
    display:inline-block;
}
ul{           
       
    list-style-type:none;
    float:left;
}

/* table样式 */
#x{
   
    text-align:center;
    vertical-align:middle;
    width:132px;
    height:43px;
    border:none;
    line-height: 43px;
    display:inline-block;
   
}
#xcondition{
    text-align:center;
    vertical-align:middle;
    width:132px;
    height:43px;
    border:none;
    line-height: 43px;
    display:inline-block;
}
/* 操作 */
#xdo{
   color: #0171F4;
    text-align:center;
    vertical-align:middle;
    width:92px;
    height:43px;
    border:none;
    line-height: 43px;
    display:inline-block;
   
}
/* 查看 */
#xcheck{
   color: #0171F4;
    text-align:center;
    vertical-align:middle;
    width:132px;
    height:43px;
    border:none;
    line-height: 43px;
    display:inline-block;
   
}
</style>
<style>
   .middle {
    height: 720px;
    width: 1200px;
    background: no-repeat center top;
    background-size:100% 100%;
    background-attachment: fixed;
}

#first-class{
    float: left;
}
</style>