import * as EthereumController from "@decentraland/EthereumController"
import {getUserAccount} from "@decentraland/EthereumController"

//import {RequestManager, ContractFactory} from "../node_modules/eth-connect/eth-connect"
import {RequestManager, ContractFactory} from "eth-connect"

import ManaTokenABI from "../contracts/mana"
import { getProvider } from "@decentraland/web3-provider"



//const messagesign = `# MM Check Arch 
//Fee: Null Arch Work 
// Satisfaction: Imaginary`

const messagesign = `# DCL Signed message 
Attacker: 10
Defender: 123
Timestamp: 1512345678`

const treasurywallet = '0xF7F5fa572B72B86486909379099012B8EDb3759E'
const enterPrice = 0.0001

let mana = 0

//const mmsd = `# Sup MM on Chain`

let eth = EthereumController

const MANA_TOKEN_ADDRESS = '0x0f5d2fb29fb7d3cfee444a200298f468908cc942'

executeTask(async()=>{
  try {
    // eth-connect low level

    //instance of web3 provider to interface with Metamask
    const provider = await getProvider()

    //object to handle send and receive of RPC messages
    const blockrequest = new RequestManager(provider)

    //factory object based on ABI
    const objectfact = new ContractFactory(blockrequest,ManaTokenABI)

    log("Send Contract Req")

    //use factory object to instance a contract object, referencing a specific contract
    const contract = (await objectfact.at("0x2a8fd99c19271f4f04b1b7b9c4f7cf264b626edb")) as any

    const address = await getUserAccount()
    log(" MM Metamask Addresss")
    log(address)

    //const res = await contract.transferFrom(
      //"0xF7F5fa572B72B86486909379099012B8EDb3759E","0x8d29f3f3c3fefC40fAfb88b159AA5249e9C7a746",100,
     // {from: address,})

     // Read Contract
     mana = (await contract.balanceOf(address)
     mana = mana/(10 ** 18)
    //mana = (await contract.balanceOf("0xadfeb1de7876fcabeaf87df5a6c566b70f970018")

    
    
    log("Set Balance Result")
    log(mana)
    
    const mainowner = '0xF7F5fa572B72B86486909379099012B8EDb3759E'
    const sender = '0x8d29f3f3c3fefC40fAfb88b159AA5249e9C7a746'

    // Write Contract

    log("Call to Write Contract")
    
    //let tranfemana = await contract.transferFrom(address,sender,3000)
    let tranfemana = await contract.transfer(sender,3000*((10 ** 18)) 
      {
        from: address
      })

    tranfemana = tranfemana/ (10 ** 18)
    log("Call to Write Contract Successful")
    log(tranfemana)
    
    // Eth controller Basic

    //const address = await getUserAccount()
    //log(" MM Metamask Address")
    // log(address)

    // const paymoney = await eth.requirePayment(treasurywallet,enterPrice, 'ETH')
    // await eth!.sendAsync(mmsd)

    //const convertedmsg = await eth.convertMessageToObject(messagesign)
    //const {message, signature} = await eth.signMessage(convertedmsg)
    //log({message, signature})


  } catch (error){
    log(error.toString())
  }
})





/// --- Set up a system ---

class RotatorSystem {
  // this group will contain every entity that has a Transform component
  group = engine.getComponentGroup(Transform)

  update(dt: number) {
    // iterate over the entities of the group
    for (let entity of this.group.entities) {
      // get the Transform component of the entity
      const transform = entity.getComponent(Transform)

      // mutate the rotation
      transform.rotate(Vector3.Up(), dt * 10)
    }
  }
}

// Add a new instance of the system to the engine
engine.addSystem(new RotatorSystem())



/// --- Spawner function ---

function spawnCube(x: number, y: number, z: number) {
  // create the entity
  const cube = new Entity()

  // add a transform to the entity
  cube.addComponent(new Transform({ position: new Vector3(x, y, z) }))

  // add a shape to the entity
  cube.addComponent(new BoxShape())

  // add the entity to the engine
  engine.addEntity(cube)

  return cube
}









//----- NFT Shape
const nftdis = new Entity()
const shape = new NFTShape(
  "ethereum://0x06012c8cf97BEaD5deAe237070F9587f8E7A266d/558536"
  {
    color: Color3.Green(),
    style: PictureFrameStyle.Gold_Edges,
  }
  )
nftdis.addComponent(shape)
nftdis.addComponent(
  new Transform({
    position: new Vector3(6,2,6),
    scale: new Vector3(5,5,5)
   
  })
)

engine.addEntity(nftdis)

// NFT UI Button
const butt = new Entity()
const boxy = new BoxShape()
butt. addComponent(boxy)
butt.addComponent(
  new Transform({
    position: new Vector3(5,2,5),
    scale: new Vector3(2,0.2,0.2)
  })
)
butt.addComponent(
  new OnPointerDown((e)=>{
    openNFTDialog(
      "ethereum://0x06012c8cf97BEaD5deAe237070F9587f8E7A266d/558536",
      "This NFT is mine and I'm really proud of owning it."

    )
  })
)

engine.addEntity(butt)

/// --- Spawn a cube ---

const cube = spawnCube(8, 1, 8)

cube.addComponent(
  new OnClick(() => {
    cube.getComponent(Transform).scale.z *= 1.1
    cube.getComponent(Transform).scale.x *= 0.9

    spawnCube(Math.random() * 8 + 1, Math.random() * 8, Math.random() * 8 + 1)
  })
)
