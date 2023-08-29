function novatel_return = novatel_bestpos_csv(novatel_bestpos_struct, bag_file)
    
    %% Do Something
    for i = 1:length(novatel_bestpos_struct)
        
        TimeStamp(i)                                        = double(novatel_bestpos_struct{i}.Header.Stamp.Sec) + double(novatel_bestpos_struct{i}.Header.Stamp.Nsec)*(10^-9);
        DatumId(i)                                          = novatel_bestpos_struct{i}.DatumId;
        Lat(i)                                              = novatel_bestpos_struct{i}.Lat;
        Lon(i)                                              = novatel_bestpos_struct{i}.Lon;
        Hgt(i)                                              = novatel_bestpos_struct{i}.Hgt;
        Undulation(i)                                       = novatel_bestpos_struct{i}.Undulation;
        LatStdev(i)                                         = novatel_bestpos_struct{i}.LatStdev;
        LonStdev(i)                                         = novatel_bestpos_struct{i}.LonStdev;
        HgtStdev(i)                                         = novatel_bestpos_struct{i}.HgtStdev;
        DiffAge(i)                                          = novatel_bestpos_struct{i}.DiffAge;
        SolAge(i)                                           = novatel_bestpos_struct{i}.SolAge;
        NumSvs(i)                                           = novatel_bestpos_struct{i}.NumSvs;
        NumSolSvs(i)                                        = novatel_bestpos_struct{i}.NumSolSvs;
        NumL1Svs(i)                                         = novatel_bestpos_struct{i}.NumSolL1Svs;
        NumMultiSvs(i)                                      = novatel_bestpos_struct{i}.NumSolMultiSvs;
        NumSvs(i)                                           = novatel_bestpos_struct{i}.NumSvs;
        
        RTKSOLUTIONVERIFIED(i)                              = novatel_bestpos_struct{i, 1}.ExtSolStat.RTKSOLUTIONVERIFIED;
        PDPSOLUTIONISGLIDE(i)                               = novatel_bestpos_struct{i, 1}.ExtSolStat.PDPSOLUTIONISGLIDE;
        KLOBUCHARBROADCAST(i)                               = novatel_bestpos_struct{i, 1}.ExtSolStat.KLOBUCHARBROADCAST;
        SBASBROADCAST(i)                                    = novatel_bestpos_struct{i, 1}.ExtSolStat.SBASBROADCAST;
        MULTIFREQUENCYCOMPUTED(i)                           = novatel_bestpos_struct{i, 1}.ExtSolStat.MULTIFREQUENCYCOMPUTED;
        PSRDIFFCORRECTION(i)                                = novatel_bestpos_struct{i, 1}.ExtSolStat.PSRDIFFCORRECTION;
        NOVATELBLENDEDIONOVALUE(i)                          = novatel_bestpos_struct{i, 1}.ExtSolStat.NOVATELBLENDEDIONOVALUE;
        RTKASSISTACTIVE(i)                                  = novatel_bestpos_struct{i, 1}.ExtSolStat.RTKASSISTACTIVE;
        ANTENNAINFORMATIONISMISSING(i)                      = novatel_bestpos_struct{i, 1}.ExtSolStat.ANTENNAINFORMATIONISMISSING;
        RESERVED(i)                                         = novatel_bestpos_struct{i, 1}.ExtSolStat.RESERVED;
        POSITIONINCLUDESTERRAINCOMPENSATIONCORRECTIONS(i)   = novatel_bestpos_struct{i, 1}.ExtSolStat.POSITIONINCLUDESTERRAINCOMPENSATIONCORRECTIONS;
        Status(i)                                           = novatel_bestpos_struct{i, 1}.ExtSolStat.Status;
        
        FIXEDPOS(i)                                         = novatel_bestpos_struct{i, 1}.PosType.FIXEDPOS;
        FIXEDHEIGHT(i)                                      = novatel_bestpos_struct{i, 1}.PosType.FIXEDHEIGHT;
        DOPPLERVELOCITY(i)                                  = novatel_bestpos_struct{i, 1}.PosType.DOPPLERVELOCITY;
        SINGLE(i)                                           = novatel_bestpos_struct{i, 1}.PosType.SINGLE;
        PSRDIFF(i)                                          = novatel_bestpos_struct{i, 1}.PosType.PSRDIFF;
        WAAS(i)                                             = novatel_bestpos_struct{i, 1}.PosType.WAAS;
        PROPAGATED(i)                                       = novatel_bestpos_struct{i, 1}.PosType.PROPAGATED;
        L1FLOAT(i)                                          = novatel_bestpos_struct{i, 1}.PosType.L1FLOAT;
        NARROWFLOAT(i)                                      = novatel_bestpos_struct{i, 1}.PosType.NARROWFLOAT;
        L1INT(i)                                            = novatel_bestpos_struct{i, 1}.PosType.L1INT;
        WIDEINT(i)                                          = novatel_bestpos_struct{i, 1}.PosType.WIDEINT;
        NARROWINT(i)                                        = novatel_bestpos_struct{i, 1}.PosType.NARROWINT;
        RTKDIRECTINS(i)                                     = novatel_bestpos_struct{i, 1}.PosType.RTKDIRECTINS;
        INSSBAS(i)                                          = novatel_bestpos_struct{i, 1}.PosType.INSSBAS;
        INSPSRSP(i)                                         = novatel_bestpos_struct{i, 1}.PosType.INSPSRSP;
        INSPSRDIFF(i)                                       = novatel_bestpos_struct{i, 1}.PosType.INSPSRDIFF;
        INSRTKFLOAT(i)                                      = novatel_bestpos_struct{i, 1}.PosType.INSRTKFLOAT;
        INSRTKFIXED(i)                                      = novatel_bestpos_struct{i, 1}.PosType.INSRTKFIXED;
        PPPCONVERGING(i)                                    = novatel_bestpos_struct{i, 1}.PosType.PPPCONVERGING;
        PPP(i)                                              = novatel_bestpos_struct{i, 1}.PosType.PPP;
        OPERATIONAL(i)                                      = novatel_bestpos_struct{i, 1}.PosType.OPERATIONAL;
        WARNING(i)                                          = novatel_bestpos_struct{i, 1}.PosType.WARNING;
        OUTOFBOUNDS(i)                                      = novatel_bestpos_struct{i, 1}.PosType.OUTOFBOUNDS;
        INSPPPCONVERGING(i)                                 = novatel_bestpos_struct{i, 1}.PosType.INSPPPCONVERGING;
        INSPPP(i)                                           = novatel_bestpos_struct{i, 1}.PosType.INSPPP;
        PPPBASICCONVERGING(i)                               = novatel_bestpos_struct{i, 1}.PosType.PPPBASICCONVERGING;
        PPPBASIC(i)                                         = novatel_bestpos_struct{i, 1}.PosType.PPPBASIC;
        INSPPPBASICCONVERGING(i)                            = novatel_bestpos_struct{i, 1}.PosType.INSPPPBASICCONVERGING;
        INSPPPBASIC(i)                                      = novatel_bestpos_struct{i, 1}.PosType.INSPPPBASIC;
        Type(i)                                             = novatel_bestpos_struct{i, 1}.PosType.Type;
        
        
    end
    

    %% EXPORT CSV
    
    
    
    T = table(TimeStamp', DatumId', Lat', Lon', Hgt', Undulation', LatStdev', LonStdev', HgtStdev', DiffAge', SolAge', NumSvs', NumSolSvs', NumL1Svs', NumMultiSvs', NumSvs', RTKSOLUTIONVERIFIED', PDPSOLUTIONISGLIDE', KLOBUCHARBROADCAST', SBASBROADCAST', MULTIFREQUENCYCOMPUTED', PSRDIFFCORRECTION', NOVATELBLENDEDIONOVALUE', RTKASSISTACTIVE', ANTENNAINFORMATIONISMISSING', RESERVED', POSITIONINCLUDESTERRAINCOMPENSATIONCORRECTIONS', Status', FIXEDPOS', FIXEDHEIGHT', SINGLE', PSRDIFF', WAAS', PROPAGATED', L1FLOAT', NARROWFLOAT', L1INT', WIDEINT', NARROWINT', RTKDIRECTINS', INSSBAS', INSPSRSP', INSPSRDIFF', INSRTKFLOAT', INSRTKFIXED', PPPCONVERGING', PPP', OPERATIONAL', WARNING', OUTOFBOUNDS', INSPPPCONVERGING', INSPPP', PPPBASICCONVERGING', PPPBASIC', INSPPPBASICCONVERGING', INSPPPBASIC', Type');
    T.Properties.VariableNames = {'TimeStamp', 'DatumId', 'Lat', 'Lon', 'Hgt', 'Undulation', 'LatStdev', 'LonStdev', 'HgtStdev', 'DiffAge', 'SolAge', 'NumSvs', 'NumSolSvs', 'NumL1Svs', 'NumMultiSvs', 'NumSvs_2', 'RTKSOLUTIONVERIFIED', 'PDPSOLUTIONISGLIDE', 'KLOBUCHARBROADCAST', 'SBASBROADCAST', 'MULTIFREQUENCYCOMPUTED', 'PSRDIFFCORRECTION', 'NOVATELBLENDEDIONOVALUE', 'RTKASSISTACTIVE', 'ANTENNAINFORMATIONISMISSING', 'RESERVED', 'POSITIONINCLUDESTERRAINCOMPENSATIONCORRECTIONS', 'Status', 'FIXEDPOS', 'FIXEDHEIGHT', 'SINGLE', 'PSRDIFF', 'WAAS', 'PROPAGATED', 'L1FLOAT', 'NARROWFLOAT', 'L1INT', 'WIDEINT', 'NARROWINT', 'RTKDIRECTINS', 'INSSBAS', 'INSPSRSP', 'INSPSRDIFF', 'INSRTKFLOAT', 'INSRTKFIXED', 'PPPCONVERGING', 'PPP', 'OPERATIONAL', 'WARNING', 'OUTOFBOUNDS', 'INSPPPCONVERGING', 'INSPPP', 'PPPBASICCONVERGING', 'PPPBASIC', 'INSPPPBASICCONVERGING', 'INSPPPBASIC', 'Type'};
    filename = string(bag_file(1:end-4))+'_novatel_bestpos' + '.csv';
    
    writetable(T, filename)
    
    %% return as var
    novatel_return = T;
    
    
end