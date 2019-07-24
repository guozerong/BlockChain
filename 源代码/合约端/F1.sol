pragma solidity ^0.4.25;

import "./F0.sol";
import "./F2.sol";

/*
这个是子合约1，继承父合约，实现保险、兑付、授信功能
*/

contract F1 is F0{
    
    ////////////////////////////////
    /*第一部分：存储映射和编号数组*/
    ////////////////////////////////
    
    mapping(uint => Insurance) insuranceMap; //存储保险的mapping
    mapping(uint => PaymentApplication) paymentApplicationMap; //存储兑付token的mapping
    mapping(uint => Credit) creditMap; //存储企业信用的mapping
    
    mapping(string => uint[]) myInsuranceIdList; //存储与自己有关的保险的mapping
    mapping(string => uint[]) myPaymentApplicationIdList; //存储与自己有关的兑付的mapping
    mapping(string => uint[]) myCreditIdList; //存储与自己有关的信用的mapping
    
    uint[] insuranceIdList;//存储保险的key
    uint[] paymentApplicationIdList;//存储兑付申请的key
    uint[] creditIdList;//存储信用的key
    
    /*///////////////////////////////////////////////////////////////////////////////    
    /    第二部分:保险、兑付、信用功能                                              /
    /    保险：发起保单、签署保单、查询保单、修改保单状态、赔付保单、完成保单并转账 /
    /    兑付：发起兑付申请、查询兑付、处理兑付申请                                 /
    /    信用：新增授信、查询授信、修改授信                                         /
    *////////////////////////////////////////////////////////////////////////////////
    
    //1.发起保单
    //输入6：投保人、担保人、保单内容、保险类型、投保金额、时间
    function createInsurance(string initiator,string respondent,string insType,string text,uint money,string time) public {
        
        //前置条件
        require(money>=0);
        //require(accountMap[initiator].bal>=money);
        
        //获取编号
        uint insNo=insuranceIdList.length+1;
      
        //增加信息
        myInsuranceIdList[initiator].push(insNo);
        myInsuranceIdList[respondent].push(insNo);
      
        insuranceIdList.push(insNo);
        insuranceMap[insNo] = Insurance(
            {insNo:insNo,initiator:initiator,respondent:respondent,insType:insType,text:text,money:money,status:"待签署",updateTime:time});
    }
  

    //2.申请token兑付（企业、物流公司、保险公司）
    //输入4：兑付方、承兑方、兑付金额、时间
    function createPaymentApplication(string initiator,string respondent,uint money,string time) public {
                
        //前置条件
        require(money>0);
        
        //获取编号
        uint appNo=paymentApplicationIdList.length+1;
      
        //判断余额是否足够
        //require(accountMap[initiator].bal>=money);
     
        //增加信息
        myPaymentApplicationIdList[initiator].push(appNo);
        myPaymentApplicationIdList[respondent].push(appNo);
          
        paymentApplicationIdList.push(appNo);
        paymentApplicationMap[appNo] = PaymentApplication(
            {appNo:appNo,initiator:initiator,respondent:respondent,money:money,status:"待兑付",updateTime:time}); 
        
    }

    //3.新增授信
    //输入4：企业、银行、信用分、时间
    function createCredit(string enterprise,string bank,uint creditScore,string time) public {
        
        //前置条件
        require(creditScore>=0);
        
        //获取编号
        uint creNo=creditIdList.length+1;
      
        //增加信息,发放token
        //uint prevAmount=accountMap[enterprise].bal;
        myCreditIdList[bank].push(creNo);
        myCreditIdList[enterprise].push(creNo);
      
        creditIdList.push(creNo);           
        creditMap[creNo] = Credit(
            {creNo:creNo,enterprise:enterprise,bank:bank,creditScore:creditScore,updateStatus:"新增",updateTime:time}); 
    
        //发放token
        accountMap[enterprise].bal+=creditScore; 
      
        //assert(prevAmount+creditScore==accountMap[enterprise].bal);
    }    

    //4.签署保单
    //输入：保单编号、选择、时间
    function signInsurance(uint no,bool choice,string time) public {
        if(keccak256(abi.encodePacked(insuranceMap[no].status)) == keccak256(abi.encodePacked("待签署"))){
            if(choice){
                insuranceMap[no].status="已签署";
            }
            else{
                insuranceMap[no].status="已拒绝";
            }
            insuranceMap[no].updateTime=time;
        } 
    }
    
    //4.1修改保单状态
    //输入：保单编号、新状态、时间
    function modifyInsurance(uint no,string newStatus,string time) public {
        if(keccak256(abi.encodePacked(insuranceMap[no].status)) == keccak256(abi.encodePacked("已签署"))){
            insuranceMap[no].status="生效中";
            insuranceMap[no].updateTime=time;
        }
        else if(keccak256(abi.encodePacked(insuranceMap[no].status)) == keccak256(abi.encodePacked("生效中"))){
            if(keccak256(abi.encodePacked(newStatus)) == keccak256(abi.encodePacked("已失效"))||keccak256(abi.encodePacked(newStatus)) == keccak256(abi.encodePacked("待赔付"))){
                insuranceMap[no].status=newStatus;  
                insuranceMap[no].updateTime=time;
            }
        }
        else{
          
        }
    }  
  
    //4.2赔付保单
    //输入：保单编号、赔付款、时间
    function compensateInsurance(uint no,uint money,string time) public {
        //前置条件
        require(money>0);
        
        if(keccak256(abi.encodePacked(insuranceMap[no].status)) == keccak256(abi.encodePacked("待赔付"))){
            insuranceMap[no].status="已赔付";
          
            //发起转账
            string storage payer=insuranceMap[no].respondent;
            //require(checkToken(payer)>=money);
            string storage payee=insuranceMap[no].initiator;
            
            createTransfer(payer,payee,money,time);
        }
    }    
  
    //4.3完成保单并转账
    //输入：保单编号、赔付款、时间
    function finishInsurance(uint no,string time) public {
        if(keccak256(abi.encodePacked(insuranceMap[no].status)) == keccak256(abi.encodePacked("已失效"))){
            insuranceMap[no].status="已完成";
            insuranceMap[no].updateTime=time;
          
            //发起转账
            require(money>=0);
            string storage payer=insuranceMap[no].initiator;
            //require(checkToken(payer)>=money);
            string storage payee=insuranceMap[no].respondent;
            uint money=insuranceMap[no].money;
            
            createTransfer(payer,payee,money,time);
        }
    }   
  
    //5.处理token兑付（银行）
    //输入：兑付编号、选择、时间
    function signPaymentApplication(uint no,bool choice,string time) public {
        if(keccak256(abi.encodePacked(paymentApplicationMap[no].status)) == keccak256(abi.encodePacked("待兑付"))){
            if(choice){ 
                paymentApplicationMap[no].status="已兑付";
              
                //扣除token
                uint prevAmount= accountMap[accNo].bal;
                string storage accNo=paymentApplicationMap[no].initiator;
                uint money=paymentApplicationMap[no].money;
                if(prevAmount>=money){
                    accountMap[accNo].bal-=money;
                }
                
                //assert(accountMap[accNo].bal+money==prevAmount);
            }
            else{
                paymentApplicationMap[no].status="已拒绝兑付";
            }
            paymentApplicationMap[no].updateTime=time;
        }
    }
  
    //6.修改授信（银行）
    //输入：抵押编号、额度、时间
    function modifyCredit(uint no,bool choice,uint amount,string time) public {
        //前置条件
        require(amount>=0);
        
        if(choice){
            creditMap[no].creditScore+=amount;
            creditMap[no].updateStatus="上调";
            creditMap[no].updateTime=time;
      
            //发放token
            string storage enterprise=creditMap[no].enterprise;
            //uint prevAmount=accountMap[enterprise].bal;
            accountMap[enterprise].bal+=amount; 
          
            //assert(prevAmount+amount==accountMap[enterprise].bal);
        }
        else{
            if(creditMap[no].creditScore<=amount){ //若额度小于要减的数，则额度减为0
                creditMap[no].creditScore=0;
            }
            else{
                creditMap[no].creditScore-=amount;
            }
            creditMap[no].updateStatus="下调";
            creditMap[no].updateTime=time;
        }
  }  
  
    //7.查询保单
    //输入：账号；输出：与账号有关的所有记录

    //查找与用户有关的保险编号数组
    function getMyInsuranceIdList(string accNo) public view returns(uint[]) {
        return myInsuranceIdList[accNo];
    }
  
    //显示一条保险记录
    function displayInsurance(uint no) public view returns (uint ,string ,string ,string ,string ,uint){
        uint u1=insuranceMap[no].insNo;
        string storage s2=insuranceMap[no].initiator;
        string storage s3=insuranceMap[no].respondent;
        string storage s4=insuranceMap[no].text;
        string storage s5=insuranceMap[no].insType;
        uint u6=insuranceMap[no].money;
        return(u1,s2,s3,s4,s5,u6);
    }
    function displayInsurance2(uint no) public view returns (uint ,string ,string ){
        uint u1=insuranceMap[no].insNo;
        string storage s7=insuranceMap[no].status;
        string storage s8=insuranceMap[no].updateTime;
        return(u1,s7,s8);
    }
    
    
    //8.查询兑付申请
    //输入：账号；输出：与账号有关的所有记录
  
    //查找与用户有关的兑付申请编号数组
    function getmyPaymentApplicationIdList(string accNo) public view returns(uint[]) {
        return myPaymentApplicationIdList[accNo];
    }
    
    //显示一条兑付申请记录
    function displayPaymentApplication(uint no) public view returns (uint ,string ,string ,uint ,string ,string ){
        uint u1=paymentApplicationMap[no].appNo;
        string storage s2=paymentApplicationMap[no].initiator;
        string storage s3=paymentApplicationMap[no].respondent;
        uint u4=paymentApplicationMap[no].money;
        string storage s5=paymentApplicationMap[no].status;
        string storage s6=paymentApplicationMap[no].updateTime;
        return(u1,s2,s3,u4,s5,s6);
    }  

  
    //9.查询信用（银行）
    //输入：账户地址/账号；与账号有关的所有记录

  
    //查找与用户有关的授信编号数组
    function getMyCreditIdList(string accNo) public view returns(uint[]) {
        return myCreditIdList[accNo];
    }
  
    //显示一条信用记录
    function displayCredit(uint no) public view returns (uint ,string ,string ,uint ,string ,string ){
        uint u1=creditMap[no].creNo;
        string storage s2=creditMap[no].enterprise;
        string storage s3=creditMap[no].bank;
        uint u4=creditMap[no].creditScore;
        string storage s5=creditMap[no].updateStatus;
        string storage s6=creditMap[no].updateTime;
        return(u1,s2,s3,u4,s5,s6);
    }

}