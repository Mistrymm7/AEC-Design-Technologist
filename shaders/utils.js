//Rotate
vec2 rotate (vec2 uv, float th){
    return mat2(cos(th), sin(th),-sin(th), cos(th))*uv;
}

//Draw a square
vec3 sdfSquare (vec2 uv, float size, vec2 offset){
    float x = uv.x - offset.x;
    float y = uv.y - offset.y;
    
    vec2 rotated = rotate(vec2(x,y), iTime);
    float d = max(abs(rotated.x),abs(rotated.y))-size;
    
    //float d = max(abs(x),abs(y))-size;
    return d > 0. ? vec3(0.): 0.5 + 0.5*cos(iTime + uv.xyx + vec3(0,2,4));

}

//Draw a circle
vec3 sdfCircle (vec2 uv, float r, vec2 offset){
    float x = uv.x - offset.x;
    float y = uv.y - offset.y;
    
    float d = length(vec2(x,y))-r;
    //0.5 + 0.5*cos(iTime + uv.xyx + vec3(0,2,4))
    return d > 0. ? vec3(0.): 0.5 + 0.5*cos(iTime + uv.xyx + vec3(0,2,4));

}

//Background color lerp
vec3 getBackgroundColor (vec2 uv){
    uv +=0.5; //revamp uv to 0 to 1
    vec3 gradientStartColor = vec3(1.,0.,1.);
    vec3 gradientEndColor = vec3(0.,1.,1.);
    return mix(gradientStartColor,gradientEndColor, uv.y);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy; // (0 to 1);
    uv -=0.5; //-0.5 to 0.5
    uv.x *= iResolution.x/iResolution.y;

    // Time varying pixel color
   // vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));
   
    //vec3 col2 = vec3(uv,1); // gradient
    
    //vec3 col3 = vec3(0); // Solid Black color
    //if (uv.x>0.3) col3=vec3(1); 
    //col3 = vec3(step(0.3, uv.x)); //edge difference
    //col3 = vec3(step(0.3, uv),0); //step accrss (checks for x and y (1,0),(0,0)
    
    vec2 offset = vec2(0.2,0.2); //Offset the circle
    //vec2 offset = vec2(0.2*sin(iTime*2.),0.2*cos(iTime*2.)); //Offset the circle
    //vec3 col3 = sdfCircle(uv, .2, offset);
    //vec3 col3 = sdfSquare(uv, .2, offset);
    
    //float interpolatedValue = mix(0.3,1.,uv.y);
    //vec3 col3 = vec3(interpolatedValue);
    
    vec3 col3 = getBackgroundColor(uv);

    // Output to screen
    fragColor = vec4(col3,1.0);
}
