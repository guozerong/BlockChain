<template>
    <div>
        <div class="topMenu">
       <!-- 一级菜单 -->
       <ul id="first-class">
          <!-- 二级菜单:合同 -->
         <li @click="goto('/logistics/logistics')" class="dropdown">
             <a>物流管理</a>
         </li>
       
       <!-- 二级菜单:物流 -->
         <li @click="goto('/logistics/insurance')" class="dropdown">
           <a>保单管理 </a>  
             </li>
       <!-- 二级菜单:Token -->
            <li class="dropdown">
                <a>Token管理</a>
                <ul class="dropdown-content">
                 <li @click="goto('/logistics/tokenpay')">
                    <a>收支Token</a>
                 </li>
                 <li @click="goto('/logistics/tokenchange')">
                    <a>兑付Token</a>
                 </li>
              </ul>
            </li>
           
       </ul>
 </div>

<!-- 主要内容的div区域，存放网站页面的框架 -->
   <div class="mainContent">
     <!-- 显示在菜单中点击的链接用的框架 -->
    <iframe name="isFrame"></iframe>
   </div> 
    </div>      
</template>


<script>
export default {
    inject:['reload'],
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
body {
    padding:0px;
    margin:0 auto;
}
/* 设置顶部<div>区域样式 */
.topMenu {
    z-index:1;      /* 设置元素堆叠顺序，保证菜单能出现在最前端 */
     
    width:100%;    /* 设置宽度 */
    height:50px;    /* 设置指定高度。如果想要增加顶部横向导航栏的高度设置这个 */
   }
/* 设置底部<div>区域样式 */
.mainContent {
    position:absolute;  /* 这个定位是为了让这个<div>区域固定在页面底端 */
    bottom:0px;         /* 让它定位在底端 */
    overflow:hidden;    /* 溢出部分隐藏，防止出现第二个滚动条 */
    z-index:-1;         /* 设置元素堆叠顺序为最底层，为了不让它遮住下拉菜单的垂直列表项 */
     
    width:100%;         /* 设置宽度 */
    /* 因为不是所有浏览器都支持CSS3中的calc()方法，所以这里写了三条去设置高度 */
    height:-webkit-calc(100% - 50px);
    height:-moz-calc(100% - 50px);
    height:calc(100% - 50px);
 /* 这个背景颜色是测试用的，想删除可以删除 */
}
.topMenu ul{    
    margin:0 auto;        
    padding:0px;    
    list-style-type:none;  /* 去除无序列表的标识符 */
}
li {
    float:left;    /* 设置左浮动，让它列表项的方向变成水平方向 */
    background-color:#FFFFFF;         /* 设置背景颜色 */
    text-align:center;    /* 设置水平对齐方式为居中 */
    width:100px;          /* 设置固定宽度 */
    height: 30px;
    border:1px solid #000;
    margin:0px -1px -1px 0px;
    
}
.clear-repeat-border{
    margin-right:-1px;
    margin-bottom:-1px;
}

a {
    display:block;            /* 转换为块级元素，为了让点击范围能够扩充到整个<li>区域 */
    line-height:30px;         /* 设置内边距让文字垂直居中。 */
    color:#000000;            /* 修改文字初始颜色 */
    text-decoration:none;    /* 去除<a>标签的下划线 */
    margin: auto auto;
}
iframe {
    width:100%;
    height:100%;
    border:none;    /* 去除它自带的边框 */
}

div.topMenu li:hover{
    background-color: #229296;
}

li:hover>a{
    color:#000000;
}
/* 设置顶部<div>区域中的<ul>样式 */

/* 隐藏所有二级菜单 */
ul.dropdown-content {
    display:none;
}
 
/* 当鼠标放置在有下拉列表的<li>对象上时 */
li.dropdown:hover ul {
    display:block; /* 转换为列表元素，让其恢复显示 */
}

.topMenu>ul>li>a:hover{
    background-color:#229296;
}
 
ul.dropdown-content li{
    text-align:center;

}
</style>
<style>
#first-class{
    float: left;
}
</style>