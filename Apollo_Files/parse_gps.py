import sys
from cyber_py import record
from modules.drivers.gnss.proto.gnss_best_pose_pb2 import GnssBestPose

def parse_data(channelname, msg, out_folder):
    
    """
    parser images from Apollo record file
    """

    msg_GPS = GnssBestPose()
    msg_GPS.ParseFromString(msg)

    tstamp = msg_GPS.measurement_time
    temp_time = str(tstamp).split('.')
    if len(temp_time[1])==1:
        temp_time1_adj = temp_time[1] + '0'
    else:
        temp_time1_adj = temp_time[1]

    gps_time = temp_time[0] + '_' + temp_time1_adj

    gps_filename  = "gps_" + gps_time + '.txt'

    f = open(out_folder + gps_filename, 'w+b')

    data_dump  = str(msg_GPS)

    f.write(data_dump)
    f.close()