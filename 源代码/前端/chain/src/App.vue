<template>
  <div id="app">
         <router-view></router-view>
         <pro-hl v-bind:msg="title" @myEvent="someThing"></pro-hl>
  </div>
</template>

<script>
import proHl from './components/proHl';


export default {
  name: 'app',
  inject:['reload'],
  data(){
       return{
         msg:'msg',
         a:0,
        
         activeIndex:0,
       
       } 
  },

  
  components: {
    proHl,
  },
  created(){

  },
  mounted(){

  },
  methods:{
    someThing(a){
          console.log(a);
    },
    goto(url,index){
          this.$router.push(url);
          console.log(this.$route); 
          this.activeIndex =index;
          this.$router.go(0);
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  margin-top: 60px;
}

ul{
display:flex;
align-items: center;
justify-content: space-around;
height: 60px;
list-style: none;

}
li{
  list-style: none;
}
.active{
  padding: 10px 20px;
  
}
</style>

