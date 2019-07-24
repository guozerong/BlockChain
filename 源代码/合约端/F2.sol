pragma solidity ^0.4.25;

import "./F0.sol";

/*
这是子合约2，继承父合约，实现合同、物流、库存的功能
*/


contract F2 is F0{
    
    ////////////////////////////////
    /*第一部分：存储映射和编号数组*/
    ////////////////////////////////
    
    //合同、物流、库存
    mapping(uint => Contracts) contractsMap; //存储合同的mapping
    mapping(uint => Transport) transportMap; //存储物流的mapping
    mapping(uint => Inventory) inventoryMap; //存储库存的mapping
    
    mapping(string => uint[]) myContractsIdList; //存储与自己有关的合同的mapping
    mapping(string => uint[]) myTransportIdList; //存储与自己有关的物流的mapping
    mapping(string => uint[]) myInventoryIdList; //存储与自己有关的库存的mapping

    
    //存储key值的数组
    uint[] contractsIdList;//存储合同的key
    uint[] transportIdList;//存储物流的key
    uint[] inventoryIdList;//存储库存的key
    
    /*///////////////////////////////////////////////////////////////////////////////    
    /    第二部分:合同、物流、库存功能                                              /
    /    合同：发起合同、签署合同、查询合同、完成合同并转账                         /
    /    物流：发起物流、签署物流、查询物流、修改物流状态、完成物流并转账           /
    /    库存：入库、查询入库                                                       /
    *////////////////////////////////////////////////////////////////////////////////

    //1.发起合同
    //输入6：发起方、签署方、合同名称、合同内容、合同金额、时间
    function createContracts(string initiator,string respondent,string title,string text,uint money,string time) public {
      
      //前置条件
      require(money>=0);
      //require(accountMap[initiator].bal>=money);
      //require(keccak256(abi.encodePacked(accountMap[respondent].status)) == keccak256(abi.encodePacked("V")));
      
      //获取编号
      uint conNo=contractsIdList.length+1;
      
      //增加信息
      myContractsIdList[initiator].push(conNo);
      myContractsIdList[respondent].push(conNo);
      
      contractsIdList.push(conNo);
      contractsMap[conNo] = Contracts(
          {conNo:conNo,title:title,initiator:initiator, respondent:respondent,text:text,money:money,status:"待签署",updateTime:time});   
    }
        
  
    //2.发起物流
    //输入6：发货方、收货方、物流公司、物流内容、物流金额、时间
    function createTransport(string initiator,string receiver,string respondent,string text,uint money,string time) public {
      
      //前置条件
      require(money>=0);
      //require(checkToken(initiator)>=money);
      //require(keccak256(abi.encodePacked(accountMap[receiver].status)) == keccak256(abi.encodePacked("V")));
      //require(keccak256(abi.encodePacked(accountMap[respondent].status)) == keccak256(abi.encodePacked("V")));
      
      //获取编号
      uint traNo=transportIdList.length+1;
      
      //增加信息
      myTransportIdList[initiator].push(traNo);
      myTransportIdList[receiver].push(traNo);
      myTransportIdList[respondent].push(traNo);
      
      transportIdList.push(traNo);
      transportMap[traNo] = Transport(
          {traNo:traNo,initiator:initiator,receiver:receiver,respondent:respondent,text:text,money:money,status:"待签署",updateTime:time});
  }
  
    //3.新增库存
    //输入7：持有者、供应商、物流公司、物流编号、入库内容、交易金额、时间
    function createInventory(string holder,string supplier,string transport,uint traNo,string text,uint money,string time) public {
        //获取编号
        uint invNo=inventoryIdList.length+1;
      
        //增加信息
        myTransportIdList[holder].push(invNo);
      
        inventoryIdList.push(invNo);      
        inventoryMap[invNo] = Inventory(
            {invNo:invNo,holder:holder,supplier:supplier,transport:transport,traNo:traNo,text:text,money:money,updateTime:time}); 
    }   
  
    //4.签署合同
    //输入：合同编号、选择、时间    
    function signContracts(uint no,bool choice,string time) public {
        if(keccak256(abi.encodePacked(contractsMap[no].status)) == keccak256(abi.encodePacked("待签署"))){
            if(choice){
                contractsMap[no].status="已签署";
            }
            else{
                contractsMap[no].status="已拒绝";
            } 
            contractsMap[no].updateTime=time;
        }
    }
    
    //4.1完成合同并转账
    //输入：合同编号、时间
    function finishContracts(uint no,string time) public {
        if(keccak256(abi.encodePacked(contractsMap[no].status)) == keccak256(abi.encodePacked("已签署"))){
            contractsMap[no].status="已完成";
            contractsMap[no].updateTime=time;
          
            //发起转账
            string storage payer=contractsMap[no].initiator;
            string storage payee=contractsMap[no].respondent;
            uint money=contractsMap[no].money;
            require(money>=0);
            //require(checkToken(payer)>=money);
            
            createTransfer(payer,payee,money,time);
        }
    }
  
    //5.签署物流
    //输入：物流编号、选择、时间
    function signTransport(uint no,bool choice,string time) public {
        if(keccak256(abi.encodePacked(transportMap[no].status)) == keccak256(abi.encodePacked("待签署"))){
            if(choice){
                transportMap[no].status="已签署";
            }
            else{
                transportMap[no].status="已拒绝";
            }
            transportMap[no].updateTime=time;
        }      
    }

    //5.1修改物流状态
    //输入：物流编号、时间
    function modifyTransport(uint no,string time) public {
        if(keccak256(abi.encodePacked(transportMap[no].status)) == keccak256(abi.encodePacked("已签署"))){
            transportMap[no].status="已发货";
            transportMap[no].updateTime=time;
        }
        else if(keccak256(abi.encodePacked(transportMap[no].status)) == keccak256(abi.encodePacked("已发货"))){
            transportMap[no].status="已到达";
            transportMap[no].updateTime=time;
        }
        else{
            
        }
    }
  
    //5.2入库
    //输入：物流编号、时间
    function inventoryTransport(uint no,string time) public {
        if(keccak256(abi.encodePacked(transportMap[no].status)) == keccak256(abi.encodePacked("已到达"))){
            transportMap[no].status="已入库";
            transportMap[no].updateTime=time;
          
            //新增入库信息
            string storage holder=transportMap[no].receiver;
            string storage supplier=transportMap[no].initiator;
            string storage transport=transportMap[no].respondent;
            uint traNo=transportMap[no].traNo;
            string storage text=transportMap[no].text;
            uint money=transportMap[no].money;
            
            createInventory(holder,supplier,transport,traNo,text,money,time);
        }
    }
    
    //5.3完成物流订单并转账
    //输入：物流编号、时间
    function finishTransport(uint no,string time) public {
        if(keccak256(abi.encodePacked(transportMap[no].status)) == keccak256(abi.encodePacked("已入库"))){
            transportMap[no].status="已完成";
            transportMap[no].updateTime=time;
          
            //发起转账
            string storage payer=transportMap[no].initiator;
            string storage payee=transportMap[no].respondent;
            uint money=transportMap[no].money;
            require(money>=0);
            //require(checkToken(payer)>=money);
            
            createTransfer(payer,payee,money,time);
        }
    }

    //6.查询合同
    //输入：账号；输出：与账号有关的所有记录
    
    //查找与用户有关的合同编号数组
    function getmyContractsIdList(string accNo) public view returns(uint[]) {
        return myContractsIdList[accNo];
    }
    
    //展示一条记录
    function displayContracts(uint conNo) public view returns (uint ,string ,string ,string ,string ,uint){
        uint u1=contractsMap[conNo].conNo;
        string storage s2=contractsMap[conNo].title;
        string storage s3=contractsMap[conNo].initiator;
        string storage s4=contractsMap[conNo].respondent;
        string storage s5=contractsMap[conNo].text;
        uint u6=contractsMap[conNo].money;
        return (u1,s2,s3,s4,s5,u6);
    }
    function displayContracts2(uint conNo) public view returns (uint ,string ,string ){
        uint u1=contractsMap[conNo].conNo;
        string storage s7=contractsMap[conNo].status;
        string storage s8=contractsMap[conNo].updateTime;
        return (u1,s7,s8);
    }
    
    //7.查询物流订单
    //输入：账号；输出：与账号有关的所有记录
    
    //查找与用户有关的物流编号数组
    function getmyTransportIdList(string accNo) public view returns(uint[]) {
        return myTransportIdList[accNo];
    }
  
    //展示一条记录
    function displayTransport(uint traNo) public view  returns (uint,string ,string ,string ,string ,uint){
        uint u1=transportMap[traNo].traNo;
        string storage s2=transportMap[traNo].initiator;
        string storage s3=transportMap[traNo].receiver;
        string storage s4=transportMap[traNo].respondent;
        string storage s5=transportMap[traNo].text;
        uint u6=transportMap[traNo].money;
        return (u1,s2,s3,s4,s5,u6);
    }
    function displayTransport2(uint traNo) public view  returns (uint,string ,string){
        uint u1=transportMap[traNo].traNo;
        string storage s7=transportMap[traNo].status;
        string storage s8=transportMap[traNo].updateTime;
        return (u1,s7,s8);
    }
    


  
    //8.查询库存
    //输入：账号；输出：与账号有关的所有记录

    //查找与用户有关的库存编号数组
    function getmyInventoryIdList(string accNo) public view returns(uint[]) {
        return myInventoryIdList[accNo];
    }
    
    //展示一条记录
    function displayInventory(uint no) public view returns (uint ,string ,string ,string ,uint ,string){
        uint u1=inventoryMap[no].invNo;
        string storage s2=inventoryMap[no].holder;
        string storage s3=inventoryMap[no].supplier;
        string storage s4=inventoryMap[no].transport;
        uint u5=inventoryMap[no].traNo;
        string storage s6=inventoryMap[no].text;
        return (u1,s2,s3,s4,u5,s6);
    }
    function displayInventory2(uint no) public view returns (uint ,uint ,string ){
        uint u1=inventoryMap[no].invNo;
        uint u7=inventoryMap[no].money;
        string storage s8=inventoryMap[no].updateTime;
        return (u1,u7,s8);
    }


    

}