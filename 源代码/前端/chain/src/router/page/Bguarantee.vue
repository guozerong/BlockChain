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
                     贷款金额
                </li>
                 <li id="light" class="down">
                     抵押品
                </li>
                 <li id="dark" class="down">
                     抵押状态
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
                <td type="button" id="xcheck" onclick="document.getElementById('check').style.display='block';" >
                    查看
                </td>
                <td id="x" >{{user.condition}}</td>
                <td id="x" >{{user.conditiontime}}</td>
                <td type="button" id="xdo" v-on:click="accept" v-if="user.condition ==='待审核'" >
                    确认入库
                </td>
                <td type="button" id="xdo" v-on:click="accept" v-else-if="user.condition ==='赎回抵押'" >
                    退抵押品
                </td>
                <td id="xdo" v-else> 
                </td>
                <td type="button" id="xdo"  v-if="user.condition==='待审核'" v-on:click="reject">
                    拒绝入库
                </td>
                <td type="button" id="xdo" v-on:click="accept" v-else-if="user.condition ==='赎回抵押'" >
                    拒绝赎回
                </td>
                <td id="xdo" v-else>
                </td>
                

            </tr>
                    </table>
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
                    {"id":1, "name":"xx1企业", "money":"100Token","content":"","condition":"待审核","conditiontime":"2019-06-02"},
                    {"id":2, "name":"xx1企业", "money":"120Token","content":"","condition":"赎回抵押","conditiontime":"2019-06-02"}
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
/* 确认、取消按钮 */
#confirm{
    color:black;
  font-size:14px;
  width:100px;
  height: 30px;
  background-color: white;
  border:2px white;
  border-radius:5px;
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