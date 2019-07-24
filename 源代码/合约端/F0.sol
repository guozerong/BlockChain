pragma solidity ^0.4.25;


/*
这个是父类合约，实现了有关账号、转账的功能
*/

contract F0{
    //////////////////////////////
    /*第一部分：存储信息的struct*/
    /////////////////////////////
    
    struct Account { //
        string accNo;			//账户号
        string accType;         //公司类型：银行、企业、物流、保险
        string name;            //公司名
        uint bal;				//余额
        string status;			//用户状态(V:valid I:invalid)
        //address publicKey;      //公钥
    }
    
    struct Contracts{ //8
        uint conNo;				//合同编号
        string initiator;       //发起方
        string respondent;      //回复方
		string title;           //合同名称
        string text;            //合同内容
        uint money;				//合同金额
        string status;			//合同状态
        string updateTime;      //更新合同状态时间
    }
	
    struct Transport{ //8
        uint traNo;           	//物流订单编号
        string initiator;       //发起方
		string receiver;	    //收货方
        string respondent;      //物流公司
        string text;            //订单内容
        uint money;             //订单金额
        string status;          //订单状态
        string updateTime;      //更新订单状态时间
    }
	
    struct Insurance{ //8
        uint insNo;           	//保险订单编号
        string initiator;       //发起人企业
        string respondent;      //保险公司
        string text;            //保单内容
		string insType;         //保险类型
        uint money;             //保单金额
        string status;          //保单状态
        string updateTime;      //更新保单状态时间
    }
    
    struct Inventory{ //8
        uint invNo;           	//库存编号
        string holder;          //持有人
        string supplier;        //供应商
		string transport;		//物流公司
        uint traNo;           	//物流订单编号
        string text;            //入库内容
        uint money;             //交易金额
        string updateTime;      //入库时间
    }
    
    struct TransferInfo{ //5
        uint traNo;           	//转账编号
        string payer;           //付款方
        string payee;           //收款方
        uint money;             //转账金额
        string updateTime;      //转账时间
    }
    
    struct PaymentApplication{ //6
        uint appNo;           	//兑付申请编号
        string initiator;       //发起人企业/保险/物流
        string respondent;      //承兑方银行
        uint money;             //兑付金额
        string status;          //申请状态
        string updateTime;      //更新状态时间
    }
    
    struct Credit{ //7
        uint creNo;           	//信用编号
        string enterprise;      //企业
        string bank;            //授信的银行
        uint creditScore;       //信用分
        string updateStatus;    //状态更新内容
        string updateTime;      //更新状态时间
    }
    
    ////////////////////////////////
    /*第二部分：存储映射和编号数组*/
    ////////////////////////////////

    mapping(string => Account) accountMap; //存储账户的mapping
    mapping(uint => TransferInfo) transferInfoMap; //存储转账的mapping
    
    mapping(string => uint[]) myTransferInfoIdList; //存储与自己有关的转账的mapping
    
    string[] accountIdList;//存储账户的key
    uint[] transferInfoIdList;//存储转账的key
    
    
    /*////////////////////////////////////////////////    
    /    第三部分:账号、转账功能                     /
    /    账号：注册账号、查询账户信息、查看账户余额  /
    /    转账：发起转账、查询转账信息                /
    */////////////////////////////////////////////////
    
    //1.注册账号
    //输入3：账号、企业类型、企业名称
    function createAccount(string accNo,string accType,string name) public {
    	
    	//判断是不是存在
    	if (keccak256(abi.encodePacked(accountMap[accNo].status)) == keccak256(abi.encodePacked("V"))) {
            return;
        }
        
        
        //增加信息
        accountMap[accNo] = Account(
            {accNo:accNo, accType:accType,name:name,bal:0,status:"V"});
        accountIdList.push(accNo);
        
		return;
    }

    //2.发起转账
    //输入4：付款方、收款方、金额、时间
    function createTransfer(string payer,string payee,uint money,string time) public {
        
        require(money>0);
        //获取编号
        uint traNo=transferInfoIdList.length+1;
      
        //判断余额是否足够
        //require(accountMap[payer].bal>=money);
      
        //
        //uint prevAmount=accountMap[payer].bal+accountMap[payee].bal;
      
        //增加信息
        myTransferInfoIdList[payer].push(traNo);
        myTransferInfoIdList[payee].push(traNo);
          
        transferInfoIdList.push(traNo);       
        transferInfoMap[traNo] = TransferInfo(
              {traNo:traNo,payer:payer,payee:payee,money:money,updateTime:time}); 
              
        accountMap[payer].bal-=money;
        accountMap[payee].bal+=money;
              
        //判断异常
        //assert(accountMap[payer].bal+accountMap[payee].bal==prevAmount);
    }
    
    //3.查询账户信息
    //输入：账号
    
    //根据下标查找账户号
    function displayAccountList(uint no) public view returns (string){
        return accountIdList[no];
    }
    
    //展示一条记录
    function displayAccount(string accNo) public view returns (string ,string ,string ,uint ,string ){
        string storage s1=accountMap[accNo].accNo;
        string storage s2=accountMap[accNo].accType;
        string storage s3=accountMap[accNo].name;
        uint u4=accountMap[accNo].bal;
        string storage s5=accountMap[accNo].status;
        return (s1,s2,s3,u4,s5);
    }         
    
    //4.查询转账信息
    //输入：账号
  
    //查找与用户有关的转账编号数组
    function getmyTransferInfoIdList(string accNo) public view returns(uint[]) {
        return myTransferInfoIdList[accNo];
    }
  
    //展示一条记录
    function displayTransferInfo(uint no) public view returns (uint ,string ,string ,uint ,string ){
        uint u1=transferInfoMap[no].traNo;
        string storage s2=transferInfoMap[no].payer;
        string storage s3=transferInfoMap[no].payee;
        uint u4=transferInfoMap[no].money;
        string storage s5=transferInfoMap[no].updateTime;
        return(u1,s2,s3,u4,s5);
    }


    //5.查询token
    //输入：账号；输出：token值
    function checkToken(string accNo) public view returns (uint ){
        return accountMap[accNo].bal;
    }

  

}