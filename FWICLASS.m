function [ffmc,dmc,dc,isi,bui,fwi] = FWICLASS(temp,rhum,wind,prcp,ffmc0,dmc0,dc0,month)
mo = (147.2*(101.0 - ffmc0))/(59.5 + ffmc0);
if prcp>0.5
    rf = prcp-0.5;
    if mo>150
        mo = (mo+42.5*rf*exp(-100.0/(251.0-mo))*(1.0 - exp(-6.93/rf))) + (.0015*(mo - 150.0)^2)*sqrt(rf);
    elseif mo<=150
        mo = mo+42.5*rf*exp(-100.0/(251.0-mo))*(1.0 - exp(-6.93/rf));
    end
end
if mo>250
    mo=250;
end
ed = .942*(rhum^.679) + (11.0*exp((rhum-100.0)/10.0))+0.18*(21.1-temp) *(1.0 - 1.0/exp(.1150 * rhum));
if mo<ed
    ew = .618*(rhum^.753) + (10.0*exp((rhum-100.0)/10.0)) + .18*(21.1-temp)*(1.0 - 1.0/exp(.115 * rhum));
    if mo<=ew
        kl = .424*(1.0-((100.0-rhum)/100.0)^1.7)+(.0694*sqrt(wind)) *(1.0 - ((100.0 - rhum)/100.0)^8); %*Eq. 7a*
        kw = kl * (.581 * exp(.0365 * temp)); %*Eq. 7b*#
        m = ew - (ew - mo)/10.0^kw; %*Eq. 9*#
    elseif mo>ew
        m = mo;
    elseif (mo==ed)
        m = mo;
    end
elseif mo>ed
    kl =.424*(1.0-(rhum/100.0)^1.7)+(.0694*sqrt(wind))* (1.0-(rhum/100.0)^8);% #*Eq. 6a*#
    kw = kl * (.581*exp(.0365*temp));% #*Eq. 6b*#
    m = ed + (mo-ed)/10.0 ^ kw; %#*Eq. 8*#
    
end
ffmc = (59.5 * (250.0 -m)) / (147.2 + m);
if (ffmc > 101.0)
    ffmc = 101.0;
end
if (ffmc <= 0.0)
    ffmc = 0.0;
end

%% DMC calculation
el = [6.5,7.5,9.0,12.8,13.9,13.9,12.4,10.9,9.4,8.0,7.0,6.0];
if (temp < -1.1)
    temp = -1.1;
end
rk = 1.894*(temp+1.1) * (100.0-rhum) * (el(month)*0.0001); %#*Eqs. 16 and 17*#
if prcp>1.5
    ra =prcp;
    rw = 0.92*ra - 1.27;
    %             wmi = 20.0 + 280.0/exp(0.023*dmc0);
    wmi = 20 + exp(5.6348 - dmc0/43.43);
    if dmc0<=33
        b = 100/(0.5+0.3*dmc0);
    elseif dmc0 > 33.0
        if dmc0<=65
            b =14-1.4*log(dmc0);
        elseif dmc0>65
            b = 6.2 * log(dmc0) - 17.2;
        end
    end
    wmr = wmi + (1000*rw) / (48.77+b*rw);
    pr = 43.43 * (5.6348 - log(wmr-20.0));
    
elseif prcp<=1.5
    pr =dmc0;
end
if (pr<0.0)
    pr = 0.0;
end
dmc = pr + rk;
if(dmc<= 1.0)
    dmc = 1.0;
end
%% DC calculation
fl = [-1.6, -1.6, -1.6, 0.9, 3.8, 5.8, 6.4, 5.0, 2.4, 0.4, -1.6, -1.6];
t = temp;
if(t < -2.8)
    t =-2.8;
end
pe = (0.36*(t+2.8) + fl(month) )/2;
if pe <=0.0
    pe = 0.0;
end
if prcp>2.8
    ra = prcp;
    rw = 0.83*ra - 1.27; %#*Eq. 18*#
    smi = 800.0 * exp(-dc0/400.0); %#*Eq. 19*#
    dr = dc0 - 400.0*log( 1.0+((3.937*rw)/smi) ); %#*Eqs. 20 and 21*#
    if (dr > 0.0)
        dc = dr + pe;
    else
        dc =dc0;
    end
elseif prcp<=2.8
    dc = dc0 + pe;
end
%% ISI calculation
mo = 147.2*(101.0-ffmc) / (59.5+ffmc);
ff = 19.115*exp(mo*-0.1386) * (1.0+(mo^5.31)/49300000.0);
isi = ff * exp(0.05039*wind);
%% BUI calculation
if dmc <= 0.4*dc
    bui = (0.8*dc*dmc) / (dmc+0.4*dc);
else
    bui = dmc-(1.0-0.8*dc/(dmc+0.4*dc))*(0.92+(0.0114*dmc)^1.7);
end
if bui <0.0
    bui = 0.0;
end
%% FWI calcualtion
if bui <= 80.0
    bb = 0.1 * isi * (0.626*bui^0.809 + 2.0);
else
    bb = 0.1*isi*(1000.0/(25. + 108.64/exp(0.023*bui)));
end
if(bb <= 1.0)
    fwi = bb;
else
    fwi = exp(2.72 * (0.434*log(bb))^0.647);
end

end