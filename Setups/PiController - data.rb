
use_osc "localhost",4559
#remote_ip="192.168.43.1" #hotspot
remote_ip="192.168.1.3" #at home


use_osc_logging false

set :amp1, (get "/osc/AmpFaders/1")[0]
set :amp2, (get "/osc/AmpFaders/2")[0]
set :amp3, (get "/osc/AmpFaders/3")[0]
set :amp4, (get "/osc/AmpFaders/4")[0]
set :knob1,(get "/osc/FxRotary1")[0]
set :knob2,(get "/osc/FxRotary2")[0]
set :knob3,(get "/osc/FxRotary3")[0]
set :knob4,(get "/osc/FxRotary4")[0]
set :knob5,(get "/osc/FxRotary5")[0]
set :knob6,(get "/osc/FxRotary6")[0]
set :toggle1, (get "/osc/AmpToggles/1/1")[0]
set :toggle2, (get "/osc/AmpToggles/1/2")[0]
set :toggle3, (get "/osc/AmpToggles/1/3")[0]
set :toggle4, (get "/osc/AmpToggles/1/4")[0]
set :center1, (get "/osc/FxFaders/1")[0]
set :center2, (get "/osc/FxFaders/2")[0]

with_timing_guarantees false do
  live_loop :bar1 do
    sig1 = sync "/osc/AmpFaders/1"
    set :amp1,sig1[0] + 1
    sleep 0.1
  end
  
  live_loop :bar2 do
    sig2 = sync "/osc/AmpFaders/2"
    set :amp2,sig2[0] + 1
    sleep 0.1
  end
  
  live_loop :bar3 do
    sig3 = sync "/osc/AmpFaders/3"
    set :amp3,sig3[0] + 1
    sleep 0.1
  end
  
  live_loop :bar4 do
    sig4 = sync "/osc/AmpFaders/4"
    set :amp4,sig4[0] + 1
    sleep 0.1
  end
  
  live_loop :dial1 do
    sig6 = sync "/osc/FxRotary1"
    set :knob1,sig6[0]
    sleep 0.1
  end
  
  live_loop :dial2 do
    sig7 = sync "/osc/FxRotary2"
    set :knob2,sig7[0]
    sleep 0.1
  end
  
  live_loop :dial3 do
    sig8 = sync "/osc/FxRotary3"
    set :knob3,sig8[0]
    sleep 0.1
  end
  
  live_loop :dial4 do
    sig9 = sync "/osc/FxRotary4"
    set :knob4,sig9[0]
    sleep 0.1
  end
  
  live_loop :dial5 do
    sig10 = sync "/osc/FxRotary5"
    set :knob5,sig10[0]
    sleep 0.1
  end
  
  live_loop :dial6 do
    sig11 = sync "/osc/FxRotary6"
    set :knob6,sig11[0]
    sleep 0.1
  end
  
  live_loop :Toggle1 do
    sig12 = sync "/osc/AmpToggles/1/1"
    set :toggle1,sig12[0]
    sleep 0.1
  end
  
  live_loop :Toggle2 do
    sig13 = sync "/osc/AmpToggles/1/2"
    set :toggle2,sig13[0]
    sleep 0.1
  end
  
  live_loop :Toggle3 do
    sig14 = sync "/osc/AmpToggles/1/3"
    set :toggle3,sig14[0]
    sleep 0.1
  end
  
  live_loop :Toggle4 do
    sig15 = sync "/osc/AmpToggles/1/4"
    set :toggle4,sig15[0]
    sleep 0.1
  end
  
  live_loop :CenterBar1 do
    sig = sync "/osc/FxFaders/1"
    set :center1, sig[0]
    sleep 0.1
  end
  
  live_loop :CenterBar2 do
    sig = sync "/osc/FxFaders/2"
    set :center2, sig[0]
    sleep 0.1
  end
  
end