# Gutsy

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
$ gutsy generate AppName /path/to/schema.json /path/for/output/
```

Check out your generated API gem! You'll probably want to edit the `gemspec`, `README.md`, and `LICENSE.txt` to better fit your needs.

## License

See [LICENSE.txt](LICENSE.txt)
