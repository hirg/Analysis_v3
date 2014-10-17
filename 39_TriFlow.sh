#!/bin/bash
date

#. ./39_TriFlow.sh

if [ $# -eq 0 ]
  then
    Name="_39GeV_Phi_ME_"
    suffix=".root"
    List="/project/projectdirs/star/xusun/OutPut/AuAu39GeV/List/run_list/39GeV_"
    suffixlist=".list"
#    for((counter=1;counter<=629;counter=counter+1))
    for((counter=634;counter<=706;counter=counter+1)) # missing run
#    for((counter=210;counter<=215;counter=counter+1))
    do
      cp ./run.csh ./run$Name$counter.csh

      echo -n "root4star -b -q -x 'TriFlow.C(" >> run$Name$counter.csh
      echo -n '"'$List$counter$suffixlist'",' >> run$Name$counter.csh
      echo -n $counter',' >> run$Name$counter.csh
###############################mode###################################
#      echo -n 0',' >> run$Name$counter.csh  # fill ReCenterPar mode
#      echo -n 1',' >> run$Name$counter.csh  # ReCenter ShiftPar mode
#      echo -n 2',' >> run$Name$counter.csh  # Charged Flow mode
#      echo -n 3',' >> run$Name$counter.csh  # Pion and Kaon mode
#      echo -n 4',' >> run$Name$counter.csh  # Proton and Yields mode
#      echo -n 5',' >> run$Name$counter.csh  # Phi mode
      echo -n 6',' >> run$Name$counter.csh  # Lambda mode
#      echo -n 7',' >> run$Name$counter.csh  # anti-Lambda mode
###############################mode###################################

###############################energy###################################
#      echo -n 0')' >> run$Name$counter.csh  # 200GeV
      echo -n 1')' >> run$Name$counter.csh  # 39GeV
#      echo -n 2')' >> run$Name$counter.csh  # 27GeV
###############################energy###################################
      echo -n "' >! /project/projectdirs/star/xusun/OutPut/AuAu39GeV/Log/Lambda/run" >> run$Name$counter.csh
      echo -n $Name$counter >> run$Name$counter.csh
      echo ".log" >> run$Name$counter.csh

      qsub -hard -l projectio=1,scratchfree=500,h_cpu=24:00:00,h_vmem=1.8G -o /project/projectdirs/star/xusun/OutPut/AuAu39GeV/Log/Lambda/job$Name$counter.log -e /project/projectdirs/star/xusun/OutPut/AuAu39GeV/Log/Lambda/job$Name$counter.err ./run$Name$counter.csh

      mv run$Name$counter.csh /project/projectdirs/star/xusun/OutPut/AuAu39GeV/Script/TriFlow/
    done

  else
    echo "Wrong number of parameters"
fi
