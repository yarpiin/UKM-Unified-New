#!/system/bin/sh

UKM=/data/UKM;
BB=$UKM/busybox;

case "$1" in
	CPUFrequencyList)
		for CPUFREQ in `$BB cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies`; do
		LABEL=$((CPUFREQ / 1000));
			$BB echo "$CPUFREQ:\"${LABEL} MHz\", ";
		done;
	;;
	CPU1FrequencyList)
		for CPUFREQ in `$BB cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_available_frequencies`; do
		LABEL=$((CPUFREQ / 1000));
			$BB echo "$CPUFREQ:\"${LABEL} MHz\", ";
		done;
	;;
	CPU2FrequencyList)
		for CPUFREQ in `$BB cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_available_frequencies`; do
		LABEL=$((CPUFREQ / 1000));
			$BB echo "$CPUFREQ:\"${LABEL} MHz\", ";
		done;
	;;
	DefaultCPUMinFrequency)
		S=0;
		while read FREQ TIME; do
			if [ $FREQ -ge "300000" ] && [ $S -eq "0" ]; then
				S=1;
				MINCPU=$FREQ;
			fi;
		done < /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state;

		$BB echo $MINCPU;
	;;
	DefaultCPU1MinFrequency)
		S=0;
		while read FREQ TIME; do
			if [ $FREQ -ge "300000" ] && [ $S -eq "0" ]; then
				S=1;
				MINCPU=$FREQ;
			fi;
		done < /sys/devices/system/cpu/cpu2/cpufreq/stats/time_in_state;

		$BB echo $MINCPU;
	;;
	DefaultCPU2MinFrequency)
		S=0;
		while read FREQ TIME; do
			if [ $FREQ -ge "300000" ] && [ $S -eq "0" ]; then
				S=1;
				MINCPU=$FREQ;
			fi;
		done < /sys/devices/system/cpu/cpu4/cpufreq/stats/time_in_state;

		$BB echo $MINCPU;
	;;
	DefaultCPUMaxFrequency)
		while read FREQ TIME; do
			if [ $FREQ -le "2260000" ]; then
				MAXCPU=$FREQ;
			fi;
		done < /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state;

		$BB echo $MAXCPU;
	;;
	DefaultCPU1MaxFrequency)
		while read FREQ TIME; do
			if [ $FREQ -le "2260000" ]; then
				MAXCPU=$FREQ;
			fi;
		done < /sys/devices/system/cpu/cpu2/cpufreq/stats/time_in_state;

		$BB echo $MAXCPU;
	;;
	DefaultCPU2MaxFrequency)
		while read FREQ TIME; do
			if [ $FREQ -le "2260000" ]; then
				MAXCPU=$FREQ;
			fi;
		done < /sys/devices/system/cpu/cpu4/cpufreq/stats/time_in_state;

		$BB echo $MAXCPU;
	;;
	MinFreqIndex)
		ID=0;
		MAXID=8;
		while read FREQ TIME; do
			LABEL=$((FREQ / 1000));
			if [ $FREQ -gt "384000" ] && [ $ID -le $MAXID ]; then
				MFIT="$MFIT $ID:\"${LABEL} MHz\", ";
			fi;
			ID=$((ID + 1));
		done < /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state;

		$BB echo $MFIT;
	;;
	DirCPU0LimFrequency)
		$BB echo "/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq";
	;;
	DirCPU1LimFrequency)
		$BB echo "/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq";
	;;
	DirCPUMinFrequency)
		$BB echo "/sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq";
	;;
	DirCPU1MinFrequency)
		$BB echo "/sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq";
	;;
	DirCPU2MinFrequency)
		$BB echo "/sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq";
	;;
	DirCPUMaxFrequency)
		$BB echo "/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq";
	;;
	DirCPU1MaxFrequency)
		$BB echo "/sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq";
	;;
	DirCPU2MaxFrequency)
		$BB echo "/sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq";
	;;
	SetCPUMinFrequency)
		for CPU in /sys/devices/system/cpu/cpu[0-1]; do
			$BB echo 1 > $CPU/online 2> /dev/null;
			$BB echo $2 > $CPU/cpufreq/scaling_min_freq 2> /dev/null;
		done;
	;;
    SetCPU1MinFrequency)
		for CPU in /sys/devices/system/cpu/cpu[0-3]; do
			$BB echo 1 > $CPU/online 2> /dev/null;
			$BB echo $2 > $CPU/cpufreq/scaling_min_freq 2> /dev/null;
		done;
	;;
    SetCPU2MinFrequency)
		for CPU in /sys/devices/system/cpu/cpu[2-3]; do
			$BB echo 1 > $CPU/online 2> /dev/null;
			$BB echo $2 > $CPU/cpufreq/scaling_min_freq 2> /dev/null;
		done;
	;;
    SetCPU3MinFrequency)
		for CPU in /sys/devices/system/cpu/cpu[4-7]; do
			$BB echo 1 > $CPU/online 2> /dev/null;
			$BB echo $2 > $CPU/cpufreq/scaling_min_freq 2> /dev/null;
		done;
	;;
	SetCPUMaxFrequency)
		for CPU in /sys/devices/system/cpu/cpu[0-1]; do
			$BB echo 1 > $CPU/online 2> /dev/null;
			$BB echo $2 > $CPU/cpufreq/scaling_max_freq 2> /dev/null;
		done;
	;;
	SetCPU1MaxFrequency)
		for CPU in /sys/devices/system/cpu/cpu[0-3]; do
			$BB echo 1 > $CPU/online 2> /dev/null;
			$BB echo $2 > $CPU/cpufreq/scaling_max_freq 2> /dev/null;
		done;
	;;
	SetCPU2MaxFrequency)
		for CPU in /sys/devices/system/cpu/cpu[2-3]; do
			$BB echo 1 > $CPU/online 2> /dev/null;
			$BB echo $2 > $CPU/cpufreq/scaling_max_freq 2> /dev/null;
		done;
	;;
	SetCPU3MaxFrequency)
		for CPU in /sys/devices/system/cpu/cpu[4-7]; do
			$BB echo 1 > $CPU/online 2> /dev/null;
			$BB echo $2 > $CPU/cpufreq/scaling_max_freq 2> /dev/null;
		done;
	;;
	MaxCPU)
	
		MAXCPU=/sys/module/clock_cpu_8996;
		MAXCPU1=/sys/devices/system/cpu/cpu7;
		
		
		
		if [ -d "$MAXCPU" ]; then
			$BB echo "4"
		
		elif [ -d "$MAXCPU1" ]; then
			$BB echo "8"
		
		else
			$BB echo "4"
		fi;
	;;
	MaxCPUBig)
	
		MAXCPU=/sys/module/clock_cpu_8996;
		MAXCPU1=/sys/devices/system/cpu/cpu7;
		
		
		
		if [ -d "$MAXCPU" ]; then
			$BB echo "2"
		
		elif [ -d "$MAXCPU1" ]; then
			$BB echo "4"
		
		else
			$BB echo "2"
		fi;
	;;
	MaxCPULittle)
	
		MAXCPU=/sys/module/clock_cpu_8996;
		MAXCPU1=/sys/devices/system/cpu/cpu7;
		
		
		
		if [ -d "$MAXCPU" ]; then
			$BB echo "2"
		
		elif [ -d "$MAXCPU1" ]; then
			$BB echo "4"
		
		else
			$BB echo "2"
		fi;
	;;
	CPUGovernorList)
		for CPUGOV in `$BB cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors`; do
			$BB echo "\"$CPUGOV\",";
		done;
	;;
	CPU1GovernorList)
		for CPUGOV in `$BB cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_available_governors`; do
			$BB echo "\"$CPUGOV\",";
		done;
	;;
	CPU2GovernorList)
		for CPUGOV in `$BB cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_available_governors`; do
			$BB echo "\"$CPUGOV\",";
		done;
	;;
	DefaultCPUGovernor)
		$BB echo `$BB cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
	;;
	DefaultCPU1Governor)
		$BB echo `$BB cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor`
	;;
	DefaultCPU2Governor)
		$BB echo `$BB cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor`
	;;
	DirCPUGovernor)
		$BB echo "/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor";
	;;
	DirCPU1Governor)
		$BB echo "/sys/devices/system/cpu/cpu2/cpufreq/scaling_governor";
	;;
	DirCPU2Governor)
		$BB echo "/sys/devices/system/cpu/cpu4/cpufreq/scaling_governor";
	;;
	DirCPUGovernorTree)
		$BB echo "/sys/devices/system/cpu/cpufreq";
	;;
	DirCPU1GovernorTree)
		$BB echo "/sys/devices/system/cpu/cpu0/cpufreq";
	;;
	DirCPU2GovernorTree)
		$BB echo "/sys/devices/system/cpu/cpu2/cpufreq";
	;;
	DirCPU3GovernorTree)
		$BB echo "/sys/devices/system/cpu/cpu4/cpufreq";
	;;
	SetCPUGovernor)
		for CPU in /sys/devices/system/cpu/cpu[0-1]; do
			$BB echo 1 > $CPU/online 2> /dev/null;
			$BB echo $2 > $CPU/cpufreq/scaling_governor 2> /dev/null;
		done;
	;;
	SetCPU1Governor)
		for CPU in /sys/devices/system/cpu/cpu[0-3]; do
			$BB echo 1 > $CPU/online 2> /dev/null;
			$BB echo $2 > $CPU/cpufreq/scaling_governor 2> /dev/null;
		done;
	;;
    SetCPU2Governor)
		for CPU in /sys/devices/system/cpu/cpu[2-3]; do
			$BB echo 1 > $CPU/online 2> /dev/null;
			$BB echo $2 > $CPU/cpufreq/scaling_governor 2> /dev/null;
		done;
	;;
    SetCPU3Governor)
		for CPU in /sys/devices/system/cpu/cpu[4-7]; do
			$BB echo 1 > $CPU/online 2> /dev/null;
			$BB echo $2 > $CPU/cpufreq/scaling_governor 2> /dev/null;
		done;
	;;
	GPUFrequencyList)
	
		GPUFREQ=/sys/devices/platform/kgsl-2d0.0/kgsl/kgsl-2d0/gpu_available_frequencies;
		GPUFREQ1=/sys/devices/platform/kgsl-3d0.0/kgsl/kgsl-3d0/gpu_available_frequencies;
		GPUFREQ2=/sys/class/kgsl/kgsl-3d0/gpu_available_frequencies;
		GPUFREQ3=/sys/devices/platform/omap/pvrsrvkm.0/sgxfreq/frequency_list;
		GPUFREQ4=/sys/kernel/tegra_gpu/gpu_available_rates;
		GPUFREQ5=/sys/devices/platform/dfrgx/devfreq/dfrgx/available_frequencies;
		GPUFREQ6=/sys/kernel/gpu/gpu_freq_table;
		
		if [ -f "$GPUFREQ" ]; then
			for GPUFREQ in `$BB cat /sys/devices/platform/kgsl-2d0.0/kgsl/kgsl-2d0/gpu_available_frequencies | $BB tr ' ' '\n' | $BB sort -u` ; do
			LABEL=$((GPUFREQ / 1000000));
				$BB echo "$GPUFREQ:\"${LABEL} MHz\", ";
			done;
			
		elif [ -f "$GPUFREQ1" ]; then
			for GPUFREQ in `$BB cat /sys/devices/platform/kgsl-3d0.0/kgsl/kgsl-3d0/gpu_available_frequencies | $BB tr ' ' '\n' | $BB sort -u` ; do
			LABEL=$((GPUFREQ / 1000000));
				$BB echo "$GPUFREQ:\"${LABEL} MHz\", ";
			done;
			
		elif [ -f "$GPUFREQ2" ]; then
			for GPUFREQ in `$BB cat /sys/class/kgsl/kgsl-3d0/gpu_available_frequencies | $BB tr ' ' '\n' | $BB sort -u` ; do
			LABEL=$((GPUFREQ / 1000000));
				$BB echo "$GPUFREQ:\"${LABEL} MHz\", ";
			done;
			
		elif [ -f "$GPUFREQ3" ]; then
			for GPUFREQ in `$BB cat /sys/devices/platform/omap/pvrsrvkm.0/sgxfreq/frequency_list | $BB tr ' ' '\n' | $BB sort -u` ; do
			LABEL=$((GPUFREQ / 1000000));
				$BB echo "$GPUFREQ:\"${LABEL} MHz\", ";
			done;
			
		elif [ -f "$GPUFREQ4" ]; then
			for GPUFREQ in `$BB cat /sys/kernel/tegra_gpu/gpu_available_rates | $BB tr ' ' '\n' | $BB sort -u` ; do
			LABEL=$((GPUFREQ / 1000000));
				$BB echo "$GPUFREQ:\"${LABEL} MHz\", ";
			done;
			
		elif [ -f "$GPUFREQ5" ]; then
			for GPUFREQ in `$BB cat /sys/kernel/tegra_gpu/gpu_available_rates | $BB tr ' ' '\n' | $BB sort -u` ; do
			LABEL=$((GPUFREQ / 1000000));
				$BB echo "$GPUFREQ:\"${LABEL} MHz\", ";
			done;
						
		else
			for GPUFREQ in `$BB cat /sys/kernel/gpu/gpu_freq_table | $BB tr ' ' '\n' | $BB sort -u` ; do
			LABEL=$((GPUFREQ / 1));
				$BB echo "$GPUFREQ:\"${LABEL} MHz\", ";
			done;
		fi;
	;;
	DirGPUMinFrequency)
	
		GPUPW=/sys/devices/platform/kgsl-2d0.0/kgsl/kgsl-2d0/gpuclk;
		GPUPW1=/sys/devices/platform/kgsl-3d0.0/kgsl/kgsl-3d0/gpuclk;
		GPUPW2=/sys/class/kgsl/kgsl-3d0/devfreq/min_freq;
		GPUPW3=/sys/devices/platform/omap/pvrsrvkm.0/sgxfreq/frequency;
		GPUPW4=/sys/kernel/tegra_gpu/gpu_floor_rate;
		GPUPW5=/sys/devices/platform/dfrgx/devfreq/dfrgx/min_freq;
		GPUPW6=/sys/kernel/gpu/gpu_min_clock;
	
		if [ -f "$GPUPW" ]; then
			$BB echo "$GPUPW";
		
		elif [ -f "$GPUPW1" ]; then
			$BB echo "$GPUPW1";
		
		elif [ -f "$GPUPW2" ]; then
			$BB echo "$GPUPW2";
		
		elif [ -f "$GPUPW3" ]; then
			$BB echo "$GPUPW3";

		elif [ -f "$GPUPW4" ]; then
			$BB echo "$GPUPW4";
		
		elif [ -f "$GPUPW5" ]; then
			$BB echo "$GPUPW5";

        else
			$BB echo "$GPUPW6";
		fi;
	;;
	DirGPUMaxFrequency)
		
		GPUMAXFREQ=/sys/devices/platform/kgsl-2d0.0/kgsl/kgsl-2d0/max_gpuclk;
		GPUMAXFREQ1=/sys/devices/platform/kgsl-3d0.0/kgsl/kgsl-3d0/max_gpuclk;
		GPUMAXFREQ2=/sys/class/kgsl/kgsl-3d0/max_gpuclk;
		GPUMAXFREQ3=/sys/devices/platform/omap/pvrsrvkm.0/sgxfreq/frequency_limit;
		GPUMAXFREQ4=/sys/kernel/tegra_gpu/gpu_cap_rate;
		GPUMAXFREQ5=/sys/devices/platform/dfrgx/devfreq/dfrgx/max_freq;
		GPUMAXFREQ6=/sys/kernel/gpu/gpu_max_clock;
			
		if [ -f "$GPUMAXFREQ" ]; then
			$BB echo "$GPUMAXFREQ";
			
		elif [ -f "$GPUMAXFREQ1" ]; then
			$BB echo "$GPUMAXFREQ1";
			
		elif [ -f "$GPUMAXFREQ2" ]; then
			$BB echo "$GPUMAXFREQ2";
			
		elif [ -f "$GPUMAXFREQ3" ]; then
			$BB echo "$GPUMAXFREQ3";
			
		elif [ -f "$GPUMAXFREQ4" ]; then
			$BB echo "$GPUMAXFREQ4";
			
		elif [ -f "$GPUMAXFREQ5" ]; then
			$BB echo "$GPUMAXFREQ5";			
		else

			$BB echo "$GPUMAXFREQ6";
		fi;
	;;
	SetGPUMinPwrLevel)

		if [[ ! -z $3 ]]; then
			$BB echo $3 > $2;
		fi;
		
		$BB echo `$BB cat $2`;
	;;
	DefaultGPUGovernor)
		
		GPUGOV=/sys/devices/platform/kgsl-2d0.0/kgsl/kgsl-2d0/pwrscale/trustzone/governor;
		GPUGOV1=/sys/class/kgsl/kgsl-3d0/pwrscale/trustzone/governor;
		GPUGOV2=/sys/class/kgsl/kgsl-3d0/devfreq/governor;
		GPUGOV3=/sys/devices/platform/dfrgx/devfreq/dfrgx/governor;
			
		if [ -f "$GPUGOV" ]; then
			$BB echo "`$BB cat /sys/devices/platform/kgsl-2d0.0/kgsl/kgsl-2d0/pwrscale/trustzone/governor`"
			
		elif [ -f "$GPUGOV1" ]; then
			$BB echo "`$BB cat /sys/class/kgsl/kgsl-3d0/pwrscale/trustzone/governor`"
			
		elif [ -f "$GPUGOV2" ]; then
			$BB echo "`$BB cat /sys/class/kgsl/kgsl-3d0/devfreq/governor`"
			
		elif [ -f "$GPUGOV3" ]; then
			$BB echo "`$BB cat /sys/devices/platform/dfrgx/devfreq/dfrgx/governor`"
						
		else
			$BB echo "`$BB cat /sys/kernel/gpu/gpu_governor`"
		fi;
	;;
	DefaultGPUPolicyGovernor)
		
		GPUGOV=/sys/devices/platform/17500000.mali/power_policy;
			
		if [ -f "$GPUGOV" ]; then
			$BB echo "`$BB cat /sys/devices/platform/17500000.mali/power_policy`"
		fi;
	;;
	DirGPUGovernor)
		
		GPUGOV=/sys/devices/platform/kgsl-2d0.0/kgsl/kgsl-2d0/pwrscale/trustzone/governor;
		GPUGOV1=/sys/class/kgsl/kgsl-3d0/pwrscale/trustzone/governor;
		GPUGOV2=/sys/class/kgsl/kgsl-3d0/devfreq/governor;
		GPUGOV3=/sys/devices/platform/dfrgx/devfreq/dfrgx/governor;
		GPUGOV4=/sys/kernel/gpu/gpu_governor;
		
		if [ -f "$GPUGOV" ]; then
			$BB echo "$GPUGOV";
			
		elif [ -f "$GPUGOV1" ]; then
			$BB echo "$GPUGOV1";
		
		elif [ -f "$GPUGOV2" ]; then
			$BB echo "$GPUGOV2";
		
		elif [ -f "$GPUGOV3" ]; then
			$BB echo "$GPUGOV3";
				
		else
			$BB echo "$GPUGOV4";
		fi;
	;;
	GPUGovernorList)

		
		GPUGOV=/sys/devices/platform/kgsl-2d0.0/kgsl/kgsl-2d0/pwrscale/trustzone/governor;
		GPUGOV1=/sys/class/kgsl/kgsl-3d0/pwrscale/trustzone/governor;
		GPUGOV2=/sys/class/kgsl/kgsl-3d0/devfreq/governor;
		GPUGOV3=/sys/devices/platform/dfrgx/devfreq/dfrgx/governor;
		GPUGOV4=/sys/kernel/gpu/gpu_governor;
		
		if [ -f "$GPUGOV" ]; then
			$BB echo "msm-adreno-tz","performance", "powersave", "ondemand", "userspace", "cpufreq";
			
		elif [ -f "$GPUGOV1" ]; then
			$BB echo "msm-adreno-tz","performance", "powersave", "ondemand", "userspace", "cpufreq";
		
		elif [ -f "$GPUGOV2" ]; then
			$BB echo "msm-adreno-tz","performance", "powersave", "ondemand", "userspace", "cpufreq";
		
		elif [ -f "$GPUGOV3" ]; then
			$BB echo "msm-adreno-tz","performance", "powersave", "ondemand", "userspace", "cpufreq";
		
		elif [ -f "$GPUGOV4" ]; then
			$BB echo "Default","Interactive", "Static", "Booster";
								
		else
			$BB echo "msm-adreno-tz","performance", "powersave", "ondemand", "userspace", "cpufreq",;
		fi;
	;;		
	SetGPUGovernor)
		if [[ ! -z $3 ]]; then
			$BB echo $3 > $2 2> /dev/null;
		fi;
		
		$BB echo `$BB cat $2`;
	;;
	IOSchedulerList)
	
		
		if [ -f "/sys/block/mmcblk0/queue/scheduler" ]; then
			for IOSCHED in `$BB cat /sys/block/mmcblk0/queue/scheduler | $BB sed -e 's/\]//;s/\[//'`; do
				$BB echo "\"$IOSCHED\",";
			done;	

		elif [ -f "/sys/block/sda/queue/scheduler" ]; then
			for IOSCHED in `$BB cat /sys/block/sda/queue/scheduler | $BB sed -e 's/\]//;s/\[//'`; do
				$BB echo "\"$IOSCHED\",";
			done;
		fi;
	;;
	DirIOScheduler)
	
		if [ -f "/sys/block/mmcblk0/queue/scheduler" ]; then
			$BB echo "/sys/block/mmcblk0/queue/scheduler";

		elif [ -f "/sys/block/sda/queue/scheduler" ]; then
			$BB echo "/sys/block/sda/queue/scheduler";
		fi;
	;;
	DirIOSchedulerTree)
	
		if [ -d "/sys/block/mmcblk0/queue/iosched" ]; then
			$BB echo "/sys/block/mmcblk0/queue/iosched";

		elif [ -d "/sys/block/sda/queue/iosched" ]; then
			$BB echo "/sys/block/sda/queue/iosched";
		fi;
	;;
	TCPCongestionList)
	
		for TCPCC in `$BB cat /proc/sys/net/ipv4/tcp_available_congestion_control` ; do
			$BB echo "\"$TCPCC\",";
		done;
	;;
	DirTCPCongestion)
		$BB echo "/proc/sys/net/ipv4/tcp_congestion_control";
	;;
	LiveCPUFrequency)
	
        LCPU=/sys/module/clock_cpu_8996;        

		CPU0=`$BB cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq 2> /dev/null`;
		CPU1=`$BB cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq 2> /dev/null`;
		CPU2=`$BB cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq 2> /dev/null`;
		CPU3=`$BB cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq 2> /dev/null`;
		
		if [ -z "$CPU0" ]; then CPU0="Offline"; else CPU0="$((CPU0 / 1000)) MHz"; fi;
		if [ -z "$CPU1" ]; then CPU1="Offline"; else CPU1="$((CPU1 / 1000)) MHz"; fi;
		if [ -z "$CPU2" ]; then CPU2="Offline"; else CPU2="$((CPU2 / 1000)) MHz"; fi;
		if [ -z "$CPU3" ]; then CPU3="Offline"; else CPU3="$((CPU3 / 1000)) MHz"; fi;
		
		if [ -d "$LCPU" ]; then 
		$BB echo "Core 0: $CPU0@nCore 1: $CPU1";
		else
		$BB echo "Core 0: $CPU0@nCore 1: $CPU1@nCore 2: $CPU2@nCore 3: $CPU3";
		fi;
	;;
	LiveCPU1Frequency)
	
		LCPU=/sys/module/clock_cpu_8996;
		
		CPU2=`$BB cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq 2> /dev/null`;
		CPU3=`$BB cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq 2> /dev/null`;
		CPU4=`$BB cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq 2> /dev/null`;
		CPU5=`$BB cat /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq 2> /dev/null`;
		CPU6=`$BB cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq 2> /dev/null`;
		CPU7=`$BB cat /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq 2> /dev/null`;

		if [ -z "$CPU2" ]; then CPU2="Offline"; else CPU2="$((CPU2 / 1000)) MHz"; fi;
		if [ -z "$CPU3" ]; then CPU3="Offline"; else CPU3="$((CPU3 / 1000)) MHz"; fi;		
		if [ -z "$CPU4" ]; then CPU4="Offline"; else CPU4="$((CPU4 / 1000)) MHz"; fi;
		if [ -z "$CPU5" ]; then CPU5="Offline"; else CPU5="$((CPU5 / 1000)) MHz"; fi;
		if [ -z "$CPU6" ]; then CPU6="Offline"; else CPU6="$((CPU6 / 1000)) MHz"; fi;
		if [ -z "$CPU7" ]; then CPU7="Offline"; else CPU7="$((CPU7 / 1000)) MHz"; fi;
		
		if [ -d "$LCPU" ]; then 
		$BB echo "Core 2: $CPU2@nCore 3: $CPU3";
		else
		$BB echo "Core 4: $CPU4@nCore 5: $CPU5@nCore 6: $CPU6@nCore 7: $CPU7";
		fi;
	;;
	LiveCPUOnlineOffline)
	
		CPU0=`$BB cat /sys/devices/system/cpu/cpu0/online 2> /dev/null`;
		CPU1=`$BB cat /sys/devices/system/cpu/cpu1/online 2> /dev/null`;
		CPU2=`$BB cat /sys/devices/system/cpu/cpu2/online 2> /dev/null`;
		CPU3=`$BB cat /sys/devices/system/cpu/cpu3/online 2> /dev/null`;

		if [ $CPU0 == 0 ]; then CPU0="Off"; else CPU0="On"; fi;
		if [ $CPU1 == 0 ]; then CPU1="Off"; else CPU1="On"; fi;
		if [ $CPU2 == 0 ]; then CPU2="Off"; else CPU2="On"; fi;
		if [ $CPU3 == 0 ]; then CPU3="Off"; else CPU3="On"; fi;

		$BB echo "CPU Cpu Status@n";
		$BB echo "0:$CPU0 ~ 1:$CPU1 ~ 2:$CPU2 ~ 3:$CPU3@n";
	;;
	LiveCPU1OnlineOffline)
	
		CPU4=`$BB cat /sys/devices/system/cpu/cpu4/online 2> /dev/null`;
		CPU5=`$BB cat /sys/devices/system/cpu/cpu5/online 2> /dev/null`;
		CPU6=`$BB cat /sys/devices/system/cpu/cpu6/online 2> /dev/null`;
		CPU7=`$BB cat /sys/devices/system/cpu/cpu7/online 2> /dev/null`;

		if [ $CPU4 == 0 ]; then CPU4="Off"; else CPU4="On"; fi;
		if [ $CPU5 == 0 ]; then CPU5="Off"; else CPU5="On"; fi;
		if [ $CPU6 == 0 ]; then CPU6="Off"; else CPU6="On"; fi;
		if [ $CPU7 == 0 ]; then CPU7="Off"; else CPU7="On"; fi;

		$BB echo "CPU Cpu Status@n";
		$BB echo "4:$CPU4 ~ 5:$CPU5 ~ 6:$CPU6 ~ 7:$CPU7@n";
	;;
	LiveGPUFrequency)
		
		GPUCURFREQ=/sys/devices/platform/kgsl-2d0.0/kgsl/kgsl-2d0/gpuclk;
		GPUCURFREQ1=/sys/devices/platform/kgsl-3d0.0/kgsl/kgsl-3d0/gpuclk;
		GPUCURFREQ2=/sys/class/kgsl/kgsl-3d0/gpuclk;
		GPUCURFREQ3=/sys/devices/platform/omap/pvrsrvkm.0/sgxfreq/frequency;
		GPUCURFREQ4=/sys/kernel/tegra_gpu/gpu_rate;
		GPUCURFREQ5=/sys/devices/platform/dfrgx/devfreq/dfrgx/cur_freq;
		GPUCURFREQ6=/sys/kernel/gpu/gpu_clock;
		
		if [ -f "$GPUCURFREQ" ]; then
			GPUFREQ="$((`$BB cat $GPUCURFREQ` / 1000000)) MHz";
			$BB echo "$GPUFREQ";
		
		elif [ -f "$GPUCURFREQ1" ]; then
			GPUFREQ="$((`$BB cat $GPUCURFREQ1` / 1000000)) MHz";
			$BB echo "$GPUFREQ";
		
		elif [ -f "$GPUCURFREQ2" ]; then
			GPUFREQ="$((`$BB cat $GPUCURFREQ2` / 1000000)) MHz";
			$BB echo "$GPUFREQ";
		
		elif [ -f "$GPUCURFREQ3" ]; then
			GPUFREQ="$((`$BB cat $GPUCURFREQ3` / 1000000)) MHz";
			$BB echo "$GPUFREQ";
		
		elif [ -f "$GPUCURFREQ4" ]; then
			GPUFREQ="$((`$BB cat $GPUCURFREQ4` / 1000000)) MHz";
			$BB echo "$GPUFREQ";
		
		elif [ -f "$GPUCURFREQ5" ]; then
			GPUFREQ="$((`$BB cat $GPUCURFREQ4` / 1000000)) MHz";
			$BB echo "$GPUFREQ";
		
		else
			GPUFREQ="$((`$BB cat $GPUCURFREQ6` / 1)) MHz";
			$BB echo "$GPUFREQ";
		fi;
	;;
	LiveTimeCPU)
	
		STATE="";
		CNT=0;
		SUM=`$BB awk '{s+=$2} END {print s}' /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state`;
		
		while read FREQ TIME; do
			if [ "$CNT" -ge $2 ] && [ "$CNT" -le $3 ]; then
				FREQ="$((FREQ / 1000)) MHz:";
				if [ $TIME -ge "100" ]; then
					PERC=`$BB awk "BEGIN { print ( ($TIME / $SUM) * 100) }"`;
					PERC="`$BB printf "%0.1f\n" $PERC`%";
					TIME=$((TIME / 100));
					STATE="$STATE $FREQ `$BB echo - | $BB awk -v "S=$TIME" '{printf "%dh:%dm:%ds",S/(60*60),S%(60*60)/60,S%60}'` ($PERC)@n";
				fi;
			fi;
			CNT=$((CNT+1));
		done < /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state;
		
		STATE=${STATE%??};
		$BB echo "$STATE";
	;;
	LiveTimeCPU1)
		STATE="";
		CNT=0;
		SUM=`$BB awk '{s+=$2} END {print s}' /sys/devices/system/cpu/cpu2/cpufreq/stats/time_in_state`;
		
		while read FREQ TIME; do
			if [ "$CNT" -ge $2 ] && [ "$CNT" -le $3 ]; then
				FREQ="$((FREQ / 1000)) MHz:";
				if [ $TIME -ge "100" ]; then
					PERC=`$BB awk "BEGIN { print ( ($TIME / $SUM) * 100) }"`;
					PERC="`$BB printf "%0.1f\n" $PERC`%";
					TIME=$((TIME / 100));
					STATE="$STATE $FREQ `$BB echo - | $BB awk -v "S=$TIME" '{printf "%dh:%dm:%ds",S/(60*60),S%(60*60)/60,S%60}'` ($PERC)@n";
				fi;
			fi;
			CNT=$((CNT+1));
		done < /sys/devices/system/cpu/cpu2/cpufreq/stats/time_in_state;
		
		STATE=${STATE%??};
		$BB echo "$STATE";
	;;
	LiveTimeCPU2)
		STATE="";
		CNT=0;
		SUM=`$BB awk '{s+=$2} END {print s}' /sys/devices/system/cpu/cpu4/cpufreq/stats/time_in_state`;
		
		while read FREQ TIME; do
			if [ "$CNT" -ge $2 ] && [ "$CNT" -le $3 ]; then
				FREQ="$((FREQ / 1000)) MHz:";
				if [ $TIME -ge "100" ]; then
					PERC=`$BB awk "BEGIN { print ( ($TIME / $SUM) * 100) }"`;
					PERC="`$BB printf "%0.1f\n" $PERC`%";
					TIME=$((TIME / 100));
					STATE="$STATE $FREQ `$BB echo - | $BB awk -v "S=$TIME" '{printf "%dh:%dm:%ds",S/(60*60),S%(60*60)/60,S%60}'` ($PERC)@n";
				fi;
			fi;
			CNT=$((CNT+1));
		done < /sys/devices/system/cpu/cpu4/cpufreq/stats/time_in_state;
		
		STATE=${STATE%??};
		$BB echo "$STATE";
	;;
	LiveUpTimeCPU)
	
		TOTAL=`$BB awk '{ print $1 }' /proc/uptime`;
		AWAKE=$((`$BB awk '{s+=$2} END {print s}' /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state` / 100));
		SLEEP=`$BB awk "BEGIN { print ($TOTAL - $AWAKE) }"`;
		
		PERC_A=`$BB awk "BEGIN { print ( ($AWAKE / $TOTAL) * 100) }"`;
		PERC_A="`$BB printf "%0.1f\n" $PERC_A`%";
		PERC_S=`$BB awk "BEGIN { print ( ($SLEEP / $TOTAL) * 100) }"`;
		PERC_S="`$BB printf "%0.1f\n" $PERC_S`%";
		
		TOTAL=`$BB echo - | $BB awk -v "S=$TOTAL" '{printf "%dh:%dm:%ds",S/(60*60),S%(60*60)/60,S%60}'`;
		AWAKE=`$BB echo - | $BB awk -v "S=$AWAKE" '{printf "%dh:%dm:%ds",S/(60*60),S%(60*60)/60,S%60}'`;
		SLEEP=`$BB echo - | $BB awk -v "S=$SLEEP" '{printf "%dh:%dm:%ds",S/(60*60),S%(60*60)/60,S%60}'`;
		$BB echo "Total: $TOTAL (100.0%)@nSleep: $SLEEP ($PERC_S)@nAwake: $AWAKE ($PERC_A)";
	;;
	LiveUpTimeCPU1)
	
		TOTAL=`$BB awk '{ print $1 }' /proc/uptime`;
		AWAKE=$((`$BB awk '{s+=$2} END {print s}' /sys/devices/system/cpu/cpu2/cpufreq/stats/time_in_state` / 100));
		SLEEP=`$BB awk "BEGIN { print ($TOTAL - $AWAKE) }"`;
		
		PERC_A=`$BB awk "BEGIN { print ( ($AWAKE / $TOTAL) * 100) }"`;
		PERC_A="`$BB printf "%0.1f\n" $PERC_A`%";
		PERC_S=`$BB awk "BEGIN { print ( ($SLEEP / $TOTAL) * 100) }"`;
		PERC_S="`$BB printf "%0.1f\n" $PERC_S`%";
		
		TOTAL=`$BB echo - | $BB awk -v "S=$TOTAL" '{printf "%dh:%dm:%ds",S/(60*60),S%(60*60)/60,S%60}'`;
		AWAKE=`$BB echo - | $BB awk -v "S=$AWAKE" '{printf "%dh:%dm:%ds",S/(60*60),S%(60*60)/60,S%60}'`;
		SLEEP=`$BB echo - | $BB awk -v "S=$SLEEP" '{printf "%dh:%dm:%ds",S/(60*60),S%(60*60)/60,S%60}'`;
		$BB echo "Total: $TOTAL (100.0%)@nSleep: $SLEEP ($PERC_S)@nAwake: $AWAKE ($PERC_A)";
	;;
	LiveUpTimeCPU2)
	
		TOTAL=`$BB awk '{ print $1 }' /proc/uptime`;
		AWAKE=$((`$BB awk '{s+=$2} END {print s}' /sys/devices/system/cpu/cpu4/cpufreq/stats/time_in_state` / 100));
		SLEEP=`$BB awk "BEGIN { print ($TOTAL - $AWAKE) }"`;
		
		PERC_A=`$BB awk "BEGIN { print ( ($AWAKE / $TOTAL) * 100) }"`;
		PERC_A="`$BB printf "%0.1f\n" $PERC_A`%";
		PERC_S=`$BB awk "BEGIN { print ( ($SLEEP / $TOTAL) * 100) }"`;
		PERC_S="`$BB printf "%0.1f\n" $PERC_S`%";
		
		TOTAL=`$BB echo - | $BB awk -v "S=$TOTAL" '{printf "%dh:%dm:%ds",S/(60*60),S%(60*60)/60,S%60}'`;
		AWAKE=`$BB echo - | $BB awk -v "S=$AWAKE" '{printf "%dh:%dm:%ds",S/(60*60),S%(60*60)/60,S%60}'`;
		SLEEP=`$BB echo - | $BB awk -v "S=$SLEEP" '{printf "%dh:%dm:%ds",S/(60*60),S%(60*60)/60,S%60}'`;
		$BB echo "Total: $TOTAL (100.0%)@nSleep: $SLEEP ($PERC_S)@nAwake: $AWAKE ($PERC_A)";
	;;
	LiveUnUsedCPU)
	
		UNUSED="";
		while read FREQ TIME; do
			FREQ="$((FREQ / 1000)) MHz";
			if [ $TIME -lt "100" ]; then
				UNUSED="$UNUSED$FREQ, ";
			fi;
		done < /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state;
		
		UNUSED=${UNUSED%??};
		$BB echo "$UNUSED";
	;;
	LiveUnUsedCPU1)
	
		UNUSED="";
		while read FREQ TIME; do
			FREQ="$((FREQ / 1000)) MHz";
			if [ $TIME -lt "100" ]; then
				UNUSED="$UNUSED$FREQ, ";
			fi;
		done < /sys/devices/system/cpu/cpu2/cpufreq/stats/time_in_state;
		
		UNUSED=${UNUSED%??};
		$BB echo "$UNUSED";
	;;
	LiveUnUsedCPU2)
	
		UNUSED="";
		while read FREQ TIME; do
			FREQ="$((FREQ / 1000)) MHz";
			if [ $TIME -lt "100" ]; then
				UNUSED="$UNUSED$FREQ, ";
			fi;
		done < /sys/devices/system/cpu/cpu4/cpufreq/stats/time_in_state;
		
		UNUSED=${UNUSED%??};
		$BB echo "$UNUSED";
	;;
	LiveBatteryTemperature)
	
		BAT_C=`$BB awk '{ print $1 / 10 }' /sys/class/power_supply/battery/temp`;
		BAT_H=`$BB cat /sys/class/power_supply/battery/health`;

		$BB echo "$BAT_C°C@nHealth: $BAT_H";
	;;
	LiveCPUTemperature)
	
		CPU_C=/sys/class/thermal/thermal_zone7/temp;
		CPU_S=/sys/class/thermal/thermal_zone3/temp;
		CPUK=/sys/module/clock_cpu_8996;

		if [ -d "$CPUK" ]; then
			CPUT="$((`$BB cat $CPU_C` / 10)) °C";
			
			$BB echo "$CPUT"; 

        
		elif [ -f "$CPU_S" ]; then
			CPUT="$((`$BB cat $CPU_S` / 1000)) °C";
			
			$BB echo "$CPUT"; 

		else
		
			$BB echo "$((`$BB cat $CPU_C`)) °C";
			
		fi;
	;;
	LiveMemory)
	
		while read TYPE MEM KB; do
			if [ "$TYPE" = "MemTotal:" ]; then
				TOTAL="$((MEM / 1024)) MB";
			elif [ "$TYPE" = "MemFree:" ]; then
				CACHED=$((MEM / 1024));
			elif [ "$TYPE" = "Cached:" ]; then
				FREE=$((MEM / 1024));
			fi;
		done < /proc/meminfo;
		
		FREE="$((FREE + CACHED)) MB";
		$BB echo "Total: $TOTAL@nFree: $FREE";
	;;
	LiveChargeCurrent)
	
			$BB echo "mA: `$BB cat /sys/kernel/charge_levels/charge_info`"
	;;
	LiveCPU1)
		
		CPUCLST=/sys/module/clock_cpu_8996;
	
			if [ -d "$CPUCLST" ]; then
			$BB echo "KYRO 1.6 Cluster"
			else
			$BB echo "CPU 1"
			fi;
	;;
	LiveCPU2)
		
		CPUCLST=/sys/module/clock_cpu_8996;
	
			if [ -d "$CPUCLST" ]; then
			$BB echo "KYRO 2.2 Cluster"
			else
			$BB echo "CPU 2"
			fi;
	;;
	LiveChargeCurrent)
			$BB echo "mA: `$BB cat /sys/kernel/charge_levels/charge_info`"
	;;
	LiveKernelCurrent)
			$BB echo "`$BB uname -r`"
	;;
	LiveInfoCurrent)
			$BB echo "Version: 4.0.1.4 Special Edition"
	;;
	LiveMSM)
			$BB echo "Msm Hotplug Driver"
	;;
	LiveSimpleThermal)
			$BB echo "Simple Thermal Driver"
	;;
	LiveCpuBoost)
			$BB echo "CPU Boost"
	;;
	LiveThermal)
			$BB echo "Thermal Driver"
	;;
	LiveCoreControl)
			$BB echo "Core Control"
	;;
	LiveStateNotifier)
			$BB echo "State Notifier Driver"
	;;
	LiveMsmPerformance)
			$BB echo "MSM Performance Driver"
	;;
	LivePowerSuspend)
			$BB echo "Power Suspend Driver"
	;;
	LiveHima)
			$BB echo "Hima Hotplug Driver"
	;;
	LiveLazy)
			$BB echo "Lazyplug Hotplug Driver"
	;;
	LiveAsmp)
			$BB echo "AutoSMP Hotplug Driver"
	;;
	LiveIntelli)
			$BB echo "Intelliplug Hotplug Driver"
	;;
	LiveBricked)
			$BB echo "Bricked Hotplug Driver"
	;;
	LiveAuto)
			$BB echo "Auto Hotplug Driver"
	;;
	LiveDyna)
			$BB echo "Dynamic Hotplug Driver"
	;;
	LiveBlu)
			$BB echo "Blu Plug Hotplug Driver"
	;;
	LiveAlucard)
			$BB echo "Alucard Hotplug Driver"
	;;
	LiveMako)
			$BB echo "Mako Hotplug Driver"
	;;
	LiveThunder)
			$BB echo "Thunderplug Hotplug Driver"
	;;
	LiveAio)
			$BB echo "AiO Hotplug Driver"
	;;
	LiveIO)
			$BB echo "I/O Scheduler"
	;;
	LiveGamma)
			$BB echo "Gamma Settings"
	;;
	LiveGPU)
			$BB echo "GPU Control"
	;;
	LiveMemory)
			$BB echo "Vrtual Memory"
	;;
	LiveAdvanced)
			$BB echo "Advanced Settings"
	;;
	LiveHardLimit)
			$BB echo "CPU Hardlimit Driver"
	;;
esac;
