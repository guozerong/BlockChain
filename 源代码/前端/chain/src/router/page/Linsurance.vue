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
         <logisticsmenu></logisticsmenu>
         </div>
         <!-- white background -->
         <div id="bkg" style="position: absolute;  margin-top:123px; margin-left:19px; ">
                  <ul id="submenu">
                <li id="dark" class="down">
                     编号 
                </li>
                <li id="light" class="down">
                    担保人
                </li>
                 <li id="dark" class="down">
                    投保金额
                </li>
                 <li id="light" class="down">
                    保单内容 
                </li>
                 <li id="dark" class="down">
                    生效时间 
                </li>
                 <li id="light" class="down">
                    保单状态
                </li>
                 <li id="dark" class="down">
                   状态更新时间
                </li>
                    </ul>
                     <!-- data table -->
                <div style="margin-left:25px">
                    <table style="float:left;border-collapse: collapse;" >
                        <tr  v-for="user in users">
                <td id="x" >{{user.id}}</td>
                <td id="x" >{{user.guarantor}}</td>
                <td id="x" >{{user.money}}</td>
                <td type="button" id="xcheck" onclick="document.getElementById('check').style.display='block';" >
                    查看
                </td>
                <td id="x" >{{user.begintime}}</td>
                <td id="xcondition" >{{user.condition}}</td>
                <td id="x" >{{user.conditiontime}}</td>

            </tr>
                    </table>
                </div>
         </div>
          <!-- 底部按钮 -->
        <div id="ubtn" class="text" style="position: absolute;margin-top:643px;margin-left:527px;">
          
           <input type="button" id="pushbtn"  value="申请保单" onclick="document.getElementById('alert').style.display='block';">
        </div>
                      <!-- 保险 -->
    <div id="alert" style="position: absolute;margin-top:280px;margin-left:340px;">
         <div class="alert_content">
            
            <div>
                <!-- 输入栏1 -->
            <div>
                <div id="u1669" class="ax_default text_field" style="position: absolute; margin-top:20px; margin-left:110px;">
                    <input id="u1669_input" type="text" style="width:200px; height:25px;" value=""/>
                </div>

                <div id="u1671" class="text" style="position: absolute;margin-top:8px;margin-left:36px;"> 
                    <p id="home1"><span>担保人：</span></p>
                </div>
            </div>
               <!-- 输入栏2 -->
            <div>
                <div id="u1669" class="ax_default text_field" style="position: absolute; margin-top:70px; margin-left:110px;">
                    <input id="u1669_input" type="text" style="width:200px; height:25px;" value=""/>
                </div>

                <div id="u1671" class="text" style="position: absolute;margin-top:58px;margin-left:20px;"> 
                    <p id="home1"><span>投保金额：</span></p>
                </div>
            </div>
                <!-- 输入栏3 -->
            <div>
                <div id="u1669" class="ax_default text_field" style="position: absolute; margin-top:125px; margin-left:110px;">
                    <input id="u1669_input" type="text" style="width:360px; height:150px;" value=""/>
                </div>

                <div id="u1671" class="text" style="position: absolute;margin-top:108px;margin-left:20px;"> 
                    <p id="home1"><span>保单内容：</span></p>
                </div>
            </div>
            <div>
                <div id="u1672" class="ax_default text_field" style="position: absolute; margin-top:308px; margin-left:110px;">
                    <input id="u1669_input" type="text" style="width:360px; height:25px;" value=""/>
                </div>

                <div id="u1671" class="text" style="position: absolute;margin-top:294px;margin-left:52px;"> 
                    <p id="home1"><span>私钥：</span></p>
                </div>
            </div>
            <div style="position: absolute; margin-top:360px; margin-left:342px;">
            <input type="button" id="confirm"  value="确定" onclick="document.getElementById('alert').style.display='none';">
            </div>
               <div style="position: absolute; margin-top:360px; margin-left:82px;">
            <input type="button" id="confirm"  value="取消" onclick="document.getElementById('alert').style.display='none';">
            </div>
           </div>
        </div>
    </div>
 <!-- 查看内容 -->
           <div id="check" style="position: absolute;margin-top:280px;margin-left:340px;">
         <div class="check_content">
             <div style="position: absolute; margin-top:360px; margin-left:212px;">
            <input type="button" id="confirm"  value="确定" onclick="document.getElementById('check').style.display='none';">
            </div>
            <p align="left">{{content}}</p>
             
         </div>
         </div>
    </div>
   

         
</template>
<script>
import logisticsmenu from "./component/logisticsMenu"
export default {
    inject:['reload'],
    data(){
         return{
            welcome: '欢迎来到物流服务平台',
            backgroundDiv: {
            backgroundImage: 'url(' + require('./pic/logistics.jpg') + ')',
        
        },
        token:'300Token',
        users: [
                    {"id":1, "guarantor":"xx1保险", "money":"100","content":"","begintime":"2019-06-01","condition":"已到达","conditiontime":"2019-06-02"},
                    {"id":1, "guarantor":"xx1保险", "money":"200","content":"","begintime":"2019-06-01","condition":"已发货","conditiontime":"2019-06-02"}
                    ]
        }
    },
    components:{ logisticsmenu:logisticsmenu },
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
   #wel{color:#229296;
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
    background-color:#80A1CD;
    text-align:center;
    width:132px;
    height:43px;
    border:none;
    line-height: 43px;
    display:inline-block;

}
#light{
    background-color:#ABDAFB;
    text-align:center;
    width:132px;
    height:43px;
    border:none;
    line-height: 43px;
    display:inline-block;
}
#do{
    background-color:#ABDAFB;
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

/* 弹窗确认及取消按钮 */
#confirm{
    color:black;
  font-size:14px;
  width:100px;
  height: 30px;
  background-color: white;
  border:2px white;
  border-radius:5px;
}

/* 底部发起按钮 */
#pushbtn{color:#0171F4;
  font-size:14px;
  width:140px;
  height: 40px;
  background-color: white;
  border:2px white;
  border-radius:5px;
  }

  /* 弹窗 */
#alert{
    
    width:100%; height:100%;
    left:0;
    top:0;
    z-index:999;
    display: flex;
    position:relative;
    display: none;

}


/* 弹窗内容 */
#alert .alert_content{
    background: rgba(255,255,255, 0.5);
    width:500px; 
    height: 400px;
    
    border-radius: 5px;
    border-color: black;
    border:1px ;
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

/* 查看内容 */
#check{
    
    width:100%; height:100%;
    left:0;
    top:0;
    z-index:999;
    display: flex;
    position:relative;
    display: none;

}



#check .check_content{
    background: rgb(228, 243, 219);
    width:500px; 
    height: 400px;
    
    border-radius: 5px;
    border-color: black;
    border:1px ;
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