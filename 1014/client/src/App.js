import React, { useState, useEffect, useReducer} from "react";
import FruitshopContract from "./contracts/Fruitshop.json";
import getWeb3 from "./getWeb3";

import "./App.css";

const App = () => {

    const [myApple,setMyApple] = useState(1)
    let initalState = {web3:null,instance:null,account:null}
    const [state, dispatch] = useReducer(reducer,initalState)

    function reducer(state,action){
      switch(action.type){
        case "INIT":
          return{
            ...state,
            web3:action.web3,
            instance:action.instance,
            account:action.account
          }
        default:
          return {
            ...state
          }
      }
    }

    const buyApple = async () => {
      let {instance, account, web3} = state;
      await instance.buyApple({
        from:account,
        value:web3.utils.toWei("10","ether"),
        gas:90000,
      })

      setMyApple(prev => prev+1)
    }

    const sellApple = async () => {
      let {instance, account, web3} = state
      await instance.sellApple(web3.utils.toWei("10","ether"),{
        from:account,
        gas:90000,
      })
      setMyApple(0)
    }
    
    const getApple = async (instance) => {
      if(instance == null) return 
      let result = await instance.getMyapple()
      setMyApple(result.toNumber())
    }

    const getweb = async () => {
      const contract = require('@truffle/contract')
      let web3 = await getWeb3()
      let fruitshop = contract(FruitshopContract)
      fruitshop.setProvider(web3.currentProvider)
      console.log(web3)

      let instance = await fruitshop.deployed()
      let accounts = await web3.eth.getAccounts()
      console.log(instance)
      console.log(accounts)
      await dispatch({type:"INIT",web3:web3,instance:instance,account:accounts[0]})
      console.log(state)
      getApple(instance)
      //web, instance, account 값 상태에 저장
    }

    useEffect(()=>{
      getweb()
    },[])

    return (
      <div>
         <h1>사과 가격 : 10 ETH</h1>
         <button onClick = {()=>buyApple()}>Buy</button>
         <p>내가 가지고 있는 사과 : {myApple}</p>
         <button onClick = {()=>sellApple()}>Sell (판매가격은 : {myApple * 10} ETH)</button>
      </div>
    )
}

export default App;
