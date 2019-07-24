<template>
    <div>
         <div id="check" >
         <div class="check_content">
            12345
            
         </div>
         </div>
    </div>
</template>

<script>
export default {
    
}
</script>

<style>
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
    background: rgba(255,255,255, 0.5);
    width:500px; 
    height: 400px;
    
    border-radius: 5px;
    border-color: black;
    border:1px ;
}
</style>
