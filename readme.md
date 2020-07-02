# blender-xatlas

I'm so sorry. This is not good. I have no idea what I'm doing.  

This is a rough addon for blender allowing you to use xatlas to unwrap and pack your uvs  
It currently only works on Windows  
Code in /xatlas_src is modified from [xatlas](https://github.com/jpcy/xatlas/)  


## Usage

### Install
1. Add ```./addons/blender-xatlas``` to you blender addons folder
2. Once enabled it will appear under the tool option in 3D view


### Use
Warning! The tool will make a single user copy and triangulate your mesh
1. Make sure you file is saved
2. Change your settings under Xatlas Tools
3. Select the objects you wish to unwrap and unpack
4. Click ```Run Xatlas```
5. Wait for an undetermined period
6. Hopefully your unwrapped uvs should appear

## Xatlas
### Build (Windows vs2017)
1. Run ```./bin/premake.bat```
2. Open ```./build/vs2017/xatlas.sln```
3. Build
4. The Output file should be copied to ```./addons/blender-xatlas/xatlas``` automatically

### Edit Addon
```xatlas-blender.cpp```

## Status
![Works On My Machine](works_on_my_machine.png)
