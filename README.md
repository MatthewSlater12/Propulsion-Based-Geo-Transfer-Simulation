# Propulsion-Based-Geo-Transfer-Simulation
This reposity contains the counterpart to my other work, this project simulates the use of propulsive methods to move from an initial set of orbits to the geostationary ring. The delta V and time of flight is then calculated for these methods as a point of baseline comparison to the luna assist methods in the other part of the project

The main aim of my masters thesis was to analyse the use of lunar gravity assist to move a stallite from an LEO avalable from launch sites in the Uk to the GEO stationary ring. To make this analysis a baseline set of time of flight and delta V budgets as to asses the potential improvements for the lunar gravity assist methods. This simulation uses a the patched conics approximation and a set of known orbits to find the difference in the vector velocity at the points of intercept between each orbit to determine the delta V required to move from one orbit to the next.

There are two sets of simulation shown here one for the use of a Hohmann transfer and one for the use of Bi-Elliptic Transfer.

The hohmann transfer uses a defined method first to move the apgogee of the inital orbit to the altitude of the geostationary orbit then a second burn to de inclinate and circularise the orbit to the final geostationary orbit. This then generates the total delta V and time of flight values for the orbital path for each launch site.

The Bi-Elliptic transfer method uses a 3rd burn due to raising the intial orbit of the transfer to one way above the final target orbits altitude as the lower velocity at this apogee can reduce the delta V needed change inclination and raise the perigee of the orbit. The satallite then peforms a second burn at this apogee to raise the perigee to target and de inclinate the orbit, after returning to the perigee at geostationary orbit the stallite performs a cirulation burn to attain its final target orbit.

As this system uses an apogee above the target orbit that is arbitrary past the requitment that it is higher than the geostationary ring the 
