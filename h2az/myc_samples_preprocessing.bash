java -jar /home/rtm/myprograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true \
METRICS_FILE=/home/rtm/Desktop/myc_dan/NTC.mfile \
INPUT=/home/rtm/Desktop/myc_dan/NTC_H2Az_A004_S1/Aligned.sortedByCoord.out.bam \
OUTPUT=/home/rtm/Desktop/myc_dan/NTC_rmdup.bam &

java -jar /home/rtm/myprograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true \
METRICS_FILE=/home/rtm/Desktop/myc_dan/siMyc.mfile \
INPUT=/home/rtm/Desktop/myc_dan/siMyc_H2Az_A006_S3/Aligned.sortedByCoord.out.bam \
OUTPUT=/home/rtm/Desktop/myc_dan/siMyc_rmdup.bam &

python /home/rtm/myprograms/danpos-2.2.2/danpos.py dpos --paired 1 \
-o /home/rtm/Desktop/myc_dan/NTC_res /home/rtm/Desktop/myc_dan/NTC &> /home/rtm/Desktop/myc_dan/NTC.log

python /home/rtm/myprograms/danpos-2.2.2/danpos.py dpos --paired 1 \
-o /home/rtm/Desktop/myc_dan/siMyc_res /home/rtm/Desktop/myc_dan/siMyc &> /home/rtm/Desktop/myc_dan/siMyc.log

################################################################################################################
