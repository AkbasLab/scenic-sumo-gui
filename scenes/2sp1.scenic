from scenic.simulators.sumo.model import *
from scenic.core.distributions import *

model scenic.simulators.sumo.model

"""Uses allnetworksedit.net.xml"""

# In SUMO speed is in meters per second. But we imagine speed in Kilometers
# per second, so we must convert from KPH to MPS.

kph2mps = 1/3.6
mps2kph = 3.6
lanes = [1,2]
#random.choice(lanes)
ego_lane = 2
npc1_lane = 1
ego_dist = 191

ego = Car at 0 @ 0,          # Always start ego at 0 & 0
    with name "ego",         # The ego must be named ego
    with route ["E2", "E3"], # A route is required
    #with track True,         # Follow the EGO in the GUI
    with color [0,0,255,255],# Set RGBA color to Blue
    with lane ego_lane,
    with distance ego_dist,
    with speed 0 * kph2mps,
    with changeSpeed [30*kph2mps, 30]
npc1 = Car at 0 @ 2, # Other actors should be 2 units away from each other
    with name "npc1",
    with route ["E2", "E3"],
    with color [255,0,0,255], # Red
    with lane npc1_lane,
    with distance Range(-80,-20) + ego_dist,
    with speed Range(20,50) * kph2mps,
    with speedMode 32,
    with laneChange [ego_lane, Range(0,25)]

ped1 = Pedestrian at 0 @ 4,
    with name "ped1",
    with route ["-E3","E2"],
    with color [255,0,255,255], #purple
    with departTime 0,
    with distance 200.35,
    with egoWaitAtXing True


param npc1_distance = npc1.distance
param npc1_speed = npc1.speed * mps2kph
param npc1_laneChange = npc1.laneChange[1]
