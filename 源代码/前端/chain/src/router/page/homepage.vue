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
    </div>

    <div id="u6" class="ax_default label">
      <div id="u6_div" class=""></div>
      <!-- username -->
      <div id="u7" class="text" style="position: absolute;margin-top:304px;margin-left:458px;">
        <p id="home1"><span>用户名：</span></p>
      </div>
      <div id="u5" class="ax_default text_field" style="position: absolute;margin-top:318.5px;margin-left:542px;">
        <!--             用户名-->
        <input id="u5_input" type="text"  style="width:200px; height:25px;" value="" ref="account_name"/>
      </div>
    </div>


    <!-- passwordInput -->
    <div id="u9" class="ax_default label">
      <div id="u9_div" class=""></div>

      <div id="u10" class="text" style="position: absolute;margin-top:351px;margin-left:475px;">
        <p id="home1"><span>密码：</span></p>
      </div>
      <div id="u8" class="ax_default text_field" style="position: absolute;margin-top:270px;margin-left:542px;">
        <select v-model="logtype" style="width:208px;">
          <option v-for="(curriculum, index) in curriculums" :key="index">{{curriculum}}</option>
        </select>
        <span>{{selectCurriculums}}</span>
      </div>
    </div>

    <!-- login type -->
    <div id="u13" class="ax_default label">
      <div id="u3_div" class=""></div>

      <div id="u14" class="text" style="position: absolute;margin-top:253px;margin-left:440px;">
        <p id="home1"><span>登陆类型：</span></p>
      </div>
      <div id="u15" class="ax_default text_field" style="position: absolute;margin-top:368.5px;margin-left:542px;">
        <!--            密码-->
        <input id="u15_input" type="password" style="width:200px; height:25px;" value="" ref="password"  />
      </div>
    </div>

    <div id="u11" class="ax_default button">
      <div id="u11_div" class=""></div>
      <!-- login -->
      <div  id="u12" class="text" style="position: absolute;margin-top:418.5px;margin-left:657px;">


        <div v-if="logtype === '企业/保险公司/物流/银行'">
          <button type="button" id="button"  >登陆
          </button>
        </div>

        <div v-if="logtype === '企业'">
          <li @click="login('/enterprise')">
            <button type="button" id="button" >登陆
            </button>
          </li>
        </div>

        <div v-if="logtype === '保险公司'">
          <li @click="login('/insurance')">
            <button type="button" id="button" >登陆
            </button>
          </li>
        </div>

        <div v-if="logtype === '银行'">
          <!--            <a v-if="(this.$refs.password.value === '' || this.$refs.account.value === '')" > alert("账号或密码不能为空")</a>-->

          <li @click="login('/bank')">
            <button type="button" id="button" >登陆
            </button>
          </li>
        </div>

        <div v-if="logtype === '物流'">
          <li @click="login('/logistics')">
            <button type="button" id="button" >登陆
            </button>
          </li>
        </div>


      </div>
      <div id="u12" class="text" style="position: absolute;margin-top:418.5px;margin-left:542px;">
        <li @click="goto('/regist')">
          <button type="button" id="button">注册</button>
        </li>
      </div>
    </div>

  </div>

</template>

<script>
  import axios from 'axios';
  import qs from 'qs';
  export default {
    inject: ['reload'],
    data() {
      return {
        welcome: '欢迎来到金融供应链平台',
        msg: '这是首页',
        backgroundDiv: {
          backgroundImage: 'url(' + require('./pic/luck.png') + ')'

        },
        logtype: '企业/保险公司/物流/银行',
        curriculums: ['企业', '保险公司', '物流', '银行'],
        valid_data: {
          valid: 0,
          message: "gyjhgj"
        }
        // user:{
        //   account: this.$refs.account_name.value,
        //   password: this.$refs.password.value,
        //   type: this.logtype
        // }


      }
    },
    methods: {
      someThing(a) {
        console.log(a);
      },
      goto(url, index) {
        // var _this=this;
        // if (!(_this.$refs.password.value === '' || _this.$refs.account.value === '')) {
        this.$router.push(url);
        console.log(this.$route);
        this.activeIndex = index;
        // } else {
        //   alert('账号或密码不能为空');
        // }
      },
      login(url) {
        var _this = this;
        var user = {
          account: this.$refs.account_name.value,
          password: this.$refs.password.value,
          type: this.logtype
        }
        alert(user.account);
        axios({
            method: 'post',
            url: 'http://localhost:8081/login',
            data: qs.stringify(user),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8'
            }
          }
        ).then(function (response) {
            alert(response.data.valid);
            if (response.data.valid=== 1) {
              localStorage.clear();
              localStorage.setItem("User_account",user.account);
              _this.$router.push(url);

            }
            else if (response.data.valid === 0) {
              alert(response.data.message);
            }
          }
        ).catch(function (error) {
          console.log(error);
        });

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
  #button{
    color:black;
    font-size:13px;
    width:91px;
    height: 25px;
    background-color: white;
    border:2px white;
    border-radius:5px;
  }
  body{
    font-family: Helvetica, sans-serif;
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

</style>
