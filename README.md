# Propulsion-Based-Geo-Transfer-Simulation
This repository contains the counterpart to my other work, this project simulates the use of propulsive methods to move from an initial set of orbits to the geostationary ring. The delta V and time of flight is then calculated for these methods as a point of baseline comparison to the luna assist methods in the other part of the project.

The main aim of my masters thesis was to analyse the use of lunar gravity assist to move a satellite from an LEO available from launch sites in the Uk to the GEO stationary ring. To make this analysis a baseline set of time of flight and delta V budgets as to assess the potential improvements for the lunar gravity assist methods. This simulation uses the patched conics approximation and a set of known orbits to find the difference in the vector velocity at the points of intercept between each orbit to determine the delta V required to move from one orbit to the next.

There are two sets of simulation shown here one for the use of a Hohmann transfer and one for the use of Bi-Elliptic Transfer.

The Hohmann transfer uses a defined method first to move the apogee of the initial orbit to the altitude of the geostationary orbit then a second burn to de incline and circularise the orbit to the final geostationary orbit. This then generates the total delta V and time of flight values for the orbital path for each launch site.

The Bi-Elliptic transfer method uses a 3rd burn due to raising the initial orbit of the transfer to one way above the final target orbits altitude as the lower velocity at this apogee can reduce the delta V needed change inclination and raise the perigee of the orbit. The satellite then performs a second burn at this apogee to raise the perigee to target and de incline the orbit, after returning to the perigee at geostationary orbit the satellite performs a circularisation burn to attain its final target orbit.

As this system uses an apogee above the target orbit that is arbitrary past the requirement that it is higher than the geostationary ring so to run see the change in delta V per km above geo the code generates a graph of the delta V difference to propulsive methods which was then used in conjunction with a time of flight graph to choose an altitude for the transfer that has maximum delta V difference and minimum time of flight. 

----Code operatiion----

The two Project_Propogator scripts require the TRUPRO script to function so ensure it can be accessed by when running them, these scripts generate 3D graphs of the orbital paths taken when executing either Hohmann or Bi-elliptic. 

The DvCalc script can run stand alone and generates the Delta V and time of flight for Hohmann transfer for each launch site in the order SaxaVord, Sutherland and Cornwall in the results array DVT with time of flight under Transfer_Time. The data for bi elliptic was generated into the graph format and then a point chosen where the change in delta V difference was less than 1 percent and the corresponding delta V values and time of flight were extracted from the results array.
