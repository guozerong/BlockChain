<template>
  <div class="middle" :style="backgroundDiv">
    <div id="u1" class="text" style="display:none; visibility: hidden">
      <p><span></span></p>
    </div>

    <div id="u2" class="ax_default label">
      <div id="u2_div" class=""></div>
      <!-- welcome -->
      <div id="u3" class="text" style="position: absolute;margin-top:0px;margin-left:19px;">
        <p id="wel"><span>欢迎来到金融供应链平台</span></p>
      </div>
    </div>

    <!-- user name regist -->
    <div id="u1660" class="ax_default text_field" style="position: absolute; margin-top:202.5px; margin-left:542px;">

      <input id="u1660_input" type="text" style="width:200px; height:25px;" value="" ref="user_name"/>
    </div>
    <div id="u1661" class="ax_default label">
      <div id="u1661_div" class=""></div>
      <div id="u1662" class="text" style="position: absolute;margin-top:190px;margin-left:469px;">
        <p id="home1"><span>账号：</span></p>
      </div>
    </div>
    <div id="u1663" class="ax_default text_field" style="position: absolute; margin-top:252.5px; margin-left:542px;">
      <input id="u1663_input" type="password" style="width:200px; height:25px;" value="" ref="password"/>
    </div>

    <!-- user password regist  -->
    <div id="u1664" class="ax_default label">
      <div id="u1664_div" class=""></div>
      <!-- Unnamed () -->
      <div id="u1665" class="text" style="position: absolute;margin-top:240px;margin-left:472px;">
        <p id="home1"><span>密码：</span></p>
      </div>
    </div>

    <!-- Unnamed (regist type) -->
    <div id="u8" class="ax_default text_field" style="position: absolute;margin-top:309.5px;margin-left:542px;">
      <select v-model="logtype" style="width:208px;">
        <option v-for="(curriculum, index) in curriculums" :key="index">{{curriculum}}</option>
      </select>
      <span>{{selectCurriculums}}</span>
    </div>

    <!-- Unnamed (Rectangle) -->
    <div id="u1667" class="ax_default label">
      <div id="u1667_div" class=""></div>
      <!-- Unnamed () -->
      <div id="u1668" class="text" style="position: absolute;margin-top:290px;margin-left:438px;">
        <p id="home1"><span>公司类型：</span></p>
      </div>
    </div>

    <!-- 邮箱 -->
    <div id="u1669" class="ax_default text_field" style="position: absolute; margin-top:402.5px; margin-left:542px;">
      <input id="u1669_input" type="text" style="width:200px; height:25px;" value="" ref="mail"/>
    </div>

    <!-- Unnamed (Rectangle) -->
    <div id="u1670" class="ax_default label">
      <div id="u1670_div" class=""></div>
      <!-- Unnamed () -->
      <div id="u1671" class="text" style="position: absolute;margin-top:390px;margin-left:472px;">
        <p id="home1"><span>邮箱：</span></p>
      </div>
    </div>

    <!-- 公司名称 -->
    <div id="u1669" class="ax_default text_field" style="position: absolute; margin-top:352.5px; margin-left:542px;">
      <input id="u1669_input" type="text" style="width:200px; height:25px;" value="" ref="company_name"/>
    </div>

    <!-- Unnamed (Rectangle) -->
    <div id="u1670" class="ax_default label">
      <div id="u1670_div" class=""></div>
      <!-- Unnamed () -->
      <div id="u1671" class="text" style="position: absolute;margin-top:340px;margin-left:438px;">
        <p id="home1"><span>公司名称：</span></p>
      </div>
    </div>
    <!-- Unnamed (Rectangle) -->
    <div id="u1672" class="ax_default button">
      <div id="u1672_div" class=""></div>
      <!-- Unnamed () -->
      <div id="u1673" class="text" style="position: absolute;margin-top:452.5px;margin-left:597px;">

        <input type="button" id="but"  value="注册" @click='register()' onclick="document.getElementById('alert').style.display='block';">
      </div>
    </div>

    <!-- window -->

    <div id="alert" style="position: absolute;margin-top:133px;margin-left:550px;">
      <div class="alert_content">
        <div class="alert_title">注册成功!</div>
        <div class="alert-body"></div>
        <div class="alert_btn">
          <li @click="goto('/homepage')">
            <button>确定</button>
          </li>
        </div>
      </div>
    </div>

  </div>

</template>


<script>


  import axios from 'axios';
  import qs from 'qs';
  export default {
    inject:['reload'],
    data(){

      return{

        backgroundDiv: {
          backgroundImage: 'url(' + require('./pic/luck.png') + ')'

        },
        logtype: '企业/保险公司/物流/银行',
        curriculums: ['企业', '保险公司', '物流','银行'],
      }
    },
    methods:{
      someThing(a){
        console.log(a);
      },
      goto(url,index){
        this.$router.push(url);
        console.log(this.$route);
        this.activeIndex =index;
      },
      register: function () {
        // axios.post("http://localhost:8081/test2", s ={"account": this.$refs.user_name.value,
        //   "password":this.$refs.password.value,"type":this.$refs.logtype.value,"company_name":$this.refs.company_name.value,"mail":this.$refs.mail.value});
        var user = {
          "account": this.$refs.user_name.value,
          "password": this.$refs.password.value,
          "type": this.logtype,
          "company_name": this.$refs.company_name.value,
          "mail": this.$refs.mail.value
        }

        alert(this.logtype)
        axios({
            method: 'post',
            url: 'http://localhost:8081/register',
            data: qs.stringify(user),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8'
            }
          }
        ).then(

        ).catch(function (error) {
          console.log(error);
        });


        // axios.post('http://localhost:8081/test',{
        //   account: this.$refs.user_name.value,
        //   password: this.$refs.password.value
        // });
        //   s: this.$refs.user_name.value
        // })
        //   .then(response=>{
        //     console.log(response)
        //   });
      }

    }


  }
</script>

<style>
  #wel{color:#229296;
    font-size:32px;
  }
  #home1{
    color:white;
    font-size:18px;
  }
  #but{
    color:black;
    font-size:13px;
    width:88px;
    background-color: white;
    border:2px white;
    border-radius:5px;
  }



  #alert{

    width:100%; height:100%;
    left:0;
    top:0;
    z-index:999;
    display: flex;
    position:relative;
    display: none;

  }

  #alert .alert_content{
    width:200px;
    height: 100px;
    background: white;
    border-radius: 5px;
    border-color: black;
    border:1px ;
  }
  #alert .alert_title{
    padding: 10px;
    border-bottom:1px #ccc solid;
  }
  #alert .alert_body{
    height: 50px;
    line-height:50px;
    text-align:center;
  }
  #alert .alert_btn{
    position:absolute;
    margin-top:30px;
    margin-left:75px;
  }
  #alert .alert_btn botton{
    margin: 10px;
    padding: 0;
    position: absolute;
    bottom:0px;
  }
</style>

<style>
  .middle {
    height: 720px;
    width: 1200px;
    background: no-repeat center top;
    background-size: contain;


  }
</style>
