#!/usr/sgug/bin

_list="libFS        
libICE        
libSM        
libX11        
libXScrnSaver
libXau        
libXaw        
libXcomposite
libXcursor    
libXdamage    
libXdmcp    
libXext        
libXfixes    
libXfont2    
libXft        
libXi        
libXinerama    
libXmu        
libXrandr    
libXrender    
libXres        
libXt        
libXtst        
libXv        
libXvMC        
libXxf86dga    
libXxf86vm    
libdmx        
libexpat    
libfontenc    
libpciaccess
libxcb        
libxkbfile    
libxshmfence
meson        
procps-ng    
util-macros    
xbitmaps    
xcb-proto    
xcb-util    
xcb-util-cursor        
xcb-util-image        
xcb-util-keysyms    
xcb-util-renderutil    
xcb-util-wm            
xorgproto"

for item in $_list ; do 
    if [[ -e /usr/sgug/share/pkgconfig/${item}.pc ]] ; then
        _share="0"
    else
        _share="1"
    
        if [[ -e /usr/sgug/lib32/pkgconfig/${item}.pc ]] ; then
            _lib="0"
        else
		_bpc=$(find BUILD/${item}-*/ -type f -name *.pc)
			for _b in $_bpc ; do
				_bn=$(basename $_b)
				find /usr/sgug/lib32/pkgconfig/. -name $_bn
				_rl="$?"
				find /usr/sgug/share/pkgconfig/. -name $_bn
				_rs="$?"
				_sum=$(( _rl + _rs ))
				if [[ $_err -ne 0 ]] ; then
            		_lib="1"
            		echo "File $_bn for pkg $item has missing pc"
				fi
			done
			fi
        fi
done


