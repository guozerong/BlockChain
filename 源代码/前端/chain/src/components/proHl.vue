<template>
     <div>
           {{msg}}
           
     </div>
     
</template>
<script>
export default {
     name:'proHl',
     data(){
         return{
    
         }
     },
     props:{
         msg:{
             type:String,
           
         }
     },
     created(){

     },
     mounted(){

     },
     methods:{
          add(){
              this.$emit('myEvent',this.child)
          }
     }

}
</script>
<style>

</style>
