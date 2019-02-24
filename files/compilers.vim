                                                        
exec ':!gcc %'| "cpp
exec ':!python %'| "python 
exec ':!javac ' . head . '.' . extension | exec ':!java ' . head| "java
exec ':!start ' . head . '.' . extension| "html/HTML
exec ':!pdflatex %' | exec ':!start '  . head . '.pdf'| "latex
                                                                
                                            
                                    
                                    
                                                            
                                                            
                                                
