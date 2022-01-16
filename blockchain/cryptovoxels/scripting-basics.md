# No Code Animation
Animation > Add Keyframe

# Basic new Feature Creation
(Properties)
let newFeature = parcel.createFeature('vox-model')
newFeature.position.set(-4,0,1) 
newFeature.scale.set(0.75, 0.75, 0.75)  

When a feature is created it has a scale and position of [0,0,0].
Thus, remember to give it a position and a scale once created. To learn how to that, scroll down to Feature object -> Properties.

(Method)
feature.clone()
feature.position.set(-3,0,2)  

(Features Types Supported):

'vox-model'
'button'
'image'
'sign'
'polytext'
'richtext'
'audio'
'video'
'youtube'
'nft-image'
'megavox'
'text-input'
'spawn-point'

# Portal
Womps

# Public Assets

If time permits, 

# Collision 
Elevator/ Push (Grouping Objects)
  **Show Group Creation and Animation Assignment (Caution: Slow Animation Speed)
https://www.cryptovoxels.com/spaces/67d81d73-74e4-43a8-88ee-13b13ca4cbb6/play

============
# Parametric Sculpture
let mm = parcel.getFeatureById('cube1');
let mm4 = parcel.getFeatureById('cube3');

//let gg = gui.addButton('My button');

console.log('door', mm);

// mm.position.set(-2,1,0);

let mm2 = mm.clone();

console.log("Duplicate ", mm2);

// mm2.scale.set(2,2,2);
// mm2.position.set(1,1,1);

let id = 'cubestart';
//id = i.toString();
console.log("Id", id);

let k=0;

for (let i = 0; i < 10; i++) {
  k=k+0.3;
  
  let mm3 = mm.clone();
  mm3.position.set(k, k,1);
  mm3.scale.set(2,0.3,1.5);
  
  mm3.rotation.set(k, k,1);
  
  console.log("Iteration", i);
  
};







==================
# Slider (Generative Staircase Design)

// Create Object with Stair id first
let mm = parcel.getFeatureById('stair')
let steps = 3

feature.on('changed', e=>{
  //slid.set({text:e.value.toFixed(0)})
  feature.set({'text':"User Input : " + e.value.toFixed(0)})
  feature.set({'value':e.value.toFixed(0)})
  console.log("Slid Value")
  console.log(feature.get('value'))
  console.log(e)
  let steps = e.value.toFixed(0)
  let k=0;

for (let i = 0; i < steps; i++) {
  k=k+1;
  
  let mm3 = mm.clone();
  // setid
   //groupthem    
  mm3.position.set(2,1+ k*0.2,1+k*0.1);
  mm3.scale.set(2,0.1,1);
  
  console.log("Iteration", i);
  
}
  
})




let nf = parcel.createFeature('cube');

let idname = steps.toString()
nf.set({id:idname})

console.log(nf.type)

console.log(nf.id)

==================
# Vid Green (Pixel Rendering) [Advance Class]
https://www.cryptovoxels.com/spaces/e9fdb582-8ce4-4a0c-8373-96f1a81ac813/play

let m=0

feature.on('start', e=>{
  feature.screen.fill(0)
  console.log('Start')
  
  
  draw()
  
  
})

feature.on('keys', e=>{
  // let m=0
  if(e.keys.left){
    m+=1  
    // feature.screen[32*k]=255
    // console.log(m)  
    // console.log('Generating Pixels')  
    feature.screen[96 + 63*m*3]=200;
    feature.screen[96 + 65*m*3]=200 ;
    feature.screen[6336 + 65*m*3]=200 ;    
    feature.screen[12771 - 63*m*3]=200 ;    
      
      //feature.scree[i]
  }
 
})

function draw(){
 //let m=0
  // for (m; m<33; m ++){
      
 // } 

  }
==================
// API Connection [Advance]

feature.on('click', e=>{
  
  fetch('https://api.wheretheiss.at/v1/satellites')
    .then(response => response.text())
    .then(text => eval(text))
    .then(() => { 
     console.log(text)  /* now you can use your library */ })
  
 
  
})

==================
// Modify Player Position
feature.on('click', e=>{
  console.log('Button Clicked')
  console.log('Player X coordinate')
  let m = e.player.position.x;
  console.log(m)
  console.log(e.player.position)
  console.log(e)
  
  // feature.set({position:[-2,1, 1]}) 
  let posx=e.player.position.x ;
  let posy=1;
  let posz=e.player.position.z;
  
  
  
  let mm2 = new Vector3(posx , 1 ,posz);
  
  console.log('Vecotr mm2')
  console.log(mm2)
  
  
   // let newpos = [posx, posy ,posz]
  
   // feature.set({position:[-2,1, 1]}) 
  
   //feature.position.set(mm2)
  
  modify(posx,posz);

  // feature.set({position:[posx,2,posz+2]})
  
  function modify(a,b){
  
    feature.set({position:[a,2,b+2]})
    setInterval(()=>{
       posx=e.player.position.x ;
  
       posz=e.player.position.z;    
      modify(posx, posz)
    }, 1000)
      
     
   } 
  console.log(e.player.name)
   
})





