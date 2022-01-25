//Chrome Extension : 
// 1. Browserify : https://chrome.google.com/webstore/detail/requirify/gajpkncnknlljkhblhllcnnfjpbcmebm (add scripts direclty using require statement in console)
// https://stackoverflow.com/questions/15954721/can-i-add-a-resource-using-chrome-dev-tools
// 2. CORS : Eliminate CORS Error

//Add script cdn
var script = document.createElement('script');
script.src = "https://code.jquery.com/jquery-3.4.1.min.js";
document.getElementsByTagName('head')[0].appendChild(script);


//Create text DOM from console/script tag
var img = new Image();
img.src = 'https://cloud-01.isotile.com/basic/avatars/png/8680.png';

console.log(img.src)
img.width=250;
document.getElementById('id').appendChild(img);


 //Editing Html directly from console
document.bgColor="red"
const para = document.createElement('p')
const node = document.createTextNode("This is cool")
para.appendChild(node)
const element =document.getElementById("div1")

//Create text DOM from console/script tag
const element =document.querySelector('h1')
element.appendChild(para)

//Create img DOM from console/script tag
const img = document.createElement("img")
img.src = mm[0].image.image
img.width=500
document.body.appendChild(img);

//Making Fetch Calls
let res = '';
fetch('https://www.crazycrows.club/api/4933',{mode:'cors'})
    .then( response => response.json() )
    .then( data => {
        console.log(data); 
        res=data ;
    } )

//forEach Array
nftarrary.forEach((element, index) => {
tokenss.push(element.token_id);

//Map function
let mm = ress.map(o => ({token:o.token_id, image:JSON.parse(o.metadata)}))
let imgurl = [];
for (let i=0; i<7;i++){ imgurl[i] = mm[i].image.image; console.log(imgurl);}
