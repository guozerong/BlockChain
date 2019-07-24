<template>
<div id="alert">
    <div id="alert">
         <div class="alert_content">
            <div class="alert_title">注册成功</div>
            <div class="alert-body">123</div>
            <div class="alert_btn">
                <button>确定</button>
                <button>取消</button>
                </div>
            </div>
    </div>
</div>
</template>
<script>
export default {
    
}
</script>


<style>
#alert{
    width:100%; height:100%;
    background:rgba(0,0,0,0.5);
    position: fixed;
    left:0;
    top:0;
    z-index:20;
    display: flex;
}
#alert.alert_content{
    width:200px; height: 150px;
    background: white;
    border-radius: 5px;
    margin:auto;

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
    position: absolute; right:0;bottom:0;
}
#alert .alert_btn botton{
    margin: 10px;
    padding: 5px;
    }
</style>
