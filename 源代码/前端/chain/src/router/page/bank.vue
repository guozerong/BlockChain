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

         </div>
    </div>

         
</template>
<script>
import bankmenu from "./component/bankMenu"
export default {
    data(){
         return{
            welcome: '欢迎来到银行服务平台',
            backgroundDiv: {
            backgroundImage: 'url(' + require('./pic/bank.jpg') + ')'

        },
    token:'1000Token',
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