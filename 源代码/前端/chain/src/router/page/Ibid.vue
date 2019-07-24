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
         <insurancemenu></insurancemenu>
         </div>
        <!-- white background -->
         <div id="bkg" style="position: absolute;  margin-top:123px; margin-left:19px; ">
                <ul id="submenu">
                <li id="dark" class="down">
                     编号 
                </li>
                <li id="light" class="down">
                     投保人
                </li>
                 <li id="dark" class="down">
                     投保时间
                </li>
                 <li id="light" class="down">
                     投保生效日期
                </li>
                 <li id="dark" class="down">
                     投保失效日期
                </li>
                 <li id="light" class="down">
                     保险类型
                </li>
                 <li id="dark" class="down">
                     投保状态
                </li>
                    </ul>
             <!-- data table -->
                <div style="margin-left:25px">
                    <table style="float:left;border-collapse: collapse;" >
                        <tr  v-for="user in users">
                <td id="x" >{{user.id}}</td>
                <td id="x" >{{user.holder}}</td>
                <td id="x" >{{user.time}}</td>
                <td id="x" >{{user.begintime}}</td>
                <td id="x" >{{user.invalidtime}}</td>
                <td id="x" >{{user.type}}</td>
                <td id="xcondition" >{{user.condition}}</td>
            </tr>
                    </table>
                </div>
         </div>
    </div>

         
</template>
<script>
import insurancemenu from "./component/insuranceMenu"
export default {
    inject:['reload'],
    data(){
         return{
            welcome: '欢迎来到保险服务平台',
            backgroundDiv: {
            backgroundImage: 'url(' + require('./pic/insurance.jpg') + ')'

        },
        token:'300Token',
        users: [
                    {"id":1, "holder":"xx1企业", "time":"2019-06-01","begintime":"2019-06-02","invalidtime":"2019-07-01","type":"物流险","condition":"待赔付"},
                    {"id":2, "holder":"xx2企业", "time":"2019-06-01","begintime":"2019-06-03","invalidtime":"2019-09-01","type":"物流险","condition":"已签署"}
                    ]
        }
    },
    components:{ insurancemenu:insurancemenu },
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
    background-color:#80BDE2;
    text-align:center;
    width:132px;
    height:43px;
    border:none;
    line-height: 43px;
    display:inline-block;

}
#light{
    background-color:#98CFEB;
    text-align:center;
    width:132px;
    height:43px;
    border:none;
    line-height: 43px;
    display:inline-block;
}
#do{
    background-color:#98CFEB;
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