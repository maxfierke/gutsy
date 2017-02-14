# Gutsy

[![Gem Version](https://badge.fury.io/rb/gutsy.svg)](https://badge.fury.io/rb/gutsy)

<center>
<pre>
                                                                                
                                                      ╓▄╖,                      
       ,▄▓▓▒░░     ╓▄▓▓█▓▄µ ╓▄▄▄▒▄╗╦,              ╓▓▓▓▓▒░║▓                    
      ╟▓▓▓▓▄▄▄▌   ▓█▓▓▓▓▄╙▓╦ ╚▓▓▓▓▓█▒▒▒░~         ▐▓▓▓▓▓▓▓▓▓                    
      ╟▓▓▓▓██▓Å▒ ▐▓▓▓▓╣▓▓▌▐█▒▒▓█░╬░░░-⌐  `.        ▓▓▓▓▓▓▓▓▓                    
       ▀Φ▓▓▓▓▓Θ ▓▓▓▓▓▓▓▓▓▒╬▓▓▓▌δ░░░░"░      W,▓▓▓Θ `█▓▒▓▓▓▀▀                    
         └▓▀▓  ╣▓▓▓▓▓▓▓▓▓▓▓▓▀▓▄╬░           └Γ▀▓▓█▄    ▓Γ                       
           ▓ ▓▓▓▓▓▓▓▓▓▓▓▄▓▓▓▀▓▓▌▌            └▌╙▓▓▓▄  ▓▀                        
           ╙▓▄▓▓▓▓▓▓▓▓▓▀▓▓▓▓▓▌╬▒                ^▓▓▓▄▓█                         
            ▓▓ █  ╠▓▓▓▌▓▓▓▓▓▓▓▌Ü                  ▀▓▓▓                          
                   █▓▓▒▓▓▓▓▓▓▓╣Ö`^```        ,      Γ                           
                    █▓▓▓▓▓▓▓▓▌▓δ^^^^` ░░.  ,,                                   
                     ╙▓▓▓▓▓▓▓▓▓▓▌▒▒▒▄░╣▄▄▒▒▒`                                   
                     ,▓▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▌░╤                                  
       ▄ ,▄         ▄▓▓▓▓▓▓▓▓╣╬δ▒▓▓▓▄▓▓▓▓▓▓▓▓╦                                  
    ╚╣▓▓▓▓▄       ╒▓▓▓▓▓▓▓▓▓▓Ñ░-▓▓▓▓▓▒   ▀█▓▓▓▓▌▄                               
       ▀▀▓▓▓▓▌    ╙▓▓▓▓▓▀╒▓▓╡  ╫▓▒╫▓▓Θ      ▀▓▓▓▓▓╛              ▄▄▄▄▄▓▓▓▓      
          ▀▓▓▓▌   ╙▀╫▓▄▄╦▓▓▓▒╦╥▓▓╣▓▓▓▒       ,▄▓▓▓y         ▄▓▓▄▓▓█▀ΓΓ▀ΓΓ.      
           ▓▓▓▌    ▄▓▓▓▓▓▓▓▓▓▓▒▓▓╠╫▓▌░     ╔▓▓▓▓▌▄         ▓▓▓▓▓▓█              
            ▓▌▌     █▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▀`   ╓▓▓▓▓▓▌δ         ╙▓▓▓▓▀                
             ▓─      ▀▓▓▓▓▓▓▓▓▓▓▓▓▓▌   ,▓▓▓▓▓▓▒            ▐▓▓█                 
             ▓        ╙▓▓▓▓▓▓█╢▓▓▓▓▓▌ ▓▓▓▓▓▓▀`             ▓▌                   
             ▌δ         █▓▓▓▌░ ╙▓▓▀▀╘▓▓▓▓▓▓`              ╒▓▌                   
            ▐▓ ▌╓p╦▄▄▄▄,▓▓▓▓▓▌╦░▓█    ▓▓▓▓Σ               ▌▓µ                   
            ▓▌▄▓▓▓▄╠▓╣▌▄▓▓▓▓▓▓▓Θ╫▌    ^▓▓▓▌╕             ╬ ▓                    
             ▀▀▓▓▓▓▓▄▌δ▓▓▓▓█▓▓Θ⌐╟▌      ▓▓▓▌░           ╒Γ▐▓∩                   
                .▀█▓▓▓▄▓▓▓█ ▓▓░ ▒⌐       ▓▓▓▌╗▄╗╗QQQQ▒▒▓▌▓▓▌                    
                     Γ▓▓▒`  ▓▓░⌐▓         █▓▓▓▓▓▓▓▓███▀▀▀▀▀                     
                       ▓▌   ▓▓▌╦█          ╙▀                                   
                       ╫Σ  ƒ▓ΘΓ▓▄                                               
                       ╫▒ ▄█░░4                                                 
                       ▐▌╫▓░▄╝                                                  
                       ▐▓▓▓▓▀                                                   
                       ▐▓▌▌                                                     
                        ^▀Γ    
</pre>
</center>

Gutsy generates RubyGem wrappers and documentation for [heroics](https://github.com/interagent/heroics)-generated API clients from JSON schema. It's the Ruby side of the coin to [`braise`](https://github.com/IoraHealth/braise).

## Usage

```bash
$ gem install gutsy
$ gutsy generate /path/to/gutsy/config.yml /path/for/output/
```

See [`examples/config.yml`](examples/config.yml) for an example of a Gutsy configuration file.

Check out your generated API gem!

## License

See [LICENSE.txt](LICENSE.txt)
