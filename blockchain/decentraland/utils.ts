let statelog = new Entity("button");
let transmm = statelog.addComponent(
  new Transform({
    position: new Vector3(-2, 0, 0),
    scale: new Vector3(2, 2, 2),
    rotation: Quaternion.Zero(),
  })
);
statelog.addComponent(new CylinderShape());
engine.addEntity(statelog);
statelog.addComponent(
  new OnPointerDown((e) => {
    log("OnPointerDown Log of state");
    
    
    
    let component= pfs.floorModules[0].pixels[2].getComponent(PixelFloorUnit);
    log("Component", component.color);

    let material = pfs.floorModules[0].pixels[2].getComponent(Material);
    log("Original Color", material.albedoColor)
    material.albedoColor = Color3.Red();
    material.emissiveColor= Color3.White();
    log("Final Color", material.albedoColor)

    log("Array Length",pfs.floorModules[0].pixels.length)
    log("Particular Entity",pfs.floorModules[0].pixels[0])

    let offset = pfs.floorModules[0].pixels[0].getComponent(Transform);
    log("Before offset", offset.position.y)

    offset.position.y = offset.position.y +1;

    log("After offset", offset.position.y)

    /* PixelFloor.pixels.forEach(p => {;

      PixelFloor()
    */
  })
); 
log("Mapped Data", statelog);

==============
  let button = new Entity("button");
let trans = button.addComponent(
  new Transform({
    position: new Vector3(10, 0, 10),
    scale: new Vector3(1, 1, 1),
    rotation: Quaternion.Zero(),
  })
);
button.addComponent(new CylinderShape());
engine.addEntity(button);
button.addComponent(
  new OnPointerDown((e) => {
    log("OnPointerDown");
    
    let len = pfs.floorModules[0].pixels.length;

    for (let i=0; i<len; i++) {
      let entity = pfs.floorModules[0].pixels[i];

      let material = entity.getComponent(Material);
      log("Material of pixel unit ", i, "is", material.albedoColor);
    }
    
    

  })
);
log("BUTTON", button);
