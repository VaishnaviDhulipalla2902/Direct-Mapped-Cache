set terminal png truecolor             # Set output type to png
set grid                               # Turn on grid

unset log                              # Remove any previous log scaling
unset label                            # Remove any previous labels

set autoscale                          # Scale axes automatically
set xtic auto                          # set xtics automatically
set ytic auto                          # set ytics automatically


set output 'IMT2017514_graph5.png'                # Set output file
set title 'VARYING HITRATE WITH CACHE SIZE(swim.txt)'                 # Set plot title

# set datafile separator ","           # Uncomment when using CSV files

set xtic add(128,64,256,32)                                       # Add xtics at points
set ytic add(78.330,84.911,87.756,92.925)                                           # Add ytics at points

set xr[30:550]
set yr[75:100]


set xlabel "CacheSize"                 # Set X axis label
set ylabel "HitRate"                   # Set Y axis label

plot 'IMT2017514_cache.dat' using 1:2 with lines title ''
