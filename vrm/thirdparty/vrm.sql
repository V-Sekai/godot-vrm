-- MIT LICENSE iFire
-- sqlite with json1 extension

DROP TABLE IF EXISTS vrm;
CREATE TABLE vrm(id INTEGER, vrm JSON);
INSERT INTO vrm(id, vrm) values (1, json(
'{
  "asset": {
    "generator": "UniGLTF-1.28",
    "version": "2.0"
  },
  "buffers": [
    {
      "uri": "AliciaSolid_vrm-0.51_data.bin",
      "byteLength": 3945328
    }
  ],
  "bufferViews": [
    {
      "buffer": 0,
      "byteOffset": 0,
      "byteLength": 57648,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 57648,
      "byteLength": 57648,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 115296,
      "byteLength": 38432,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 153728,
      "byteLength": 76864,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 230592,
      "byteLength": 38432,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 269024,
      "byteLength": 10296,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 279320,
      "byteLength": 4680,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 284000,
      "byteLength": 76488,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 360488,
      "byteLength": 29544,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 390032,
      "byteLength": 29544,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 419576,
      "byteLength": 19696,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 439272,
      "byteLength": 39392,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 478664,
      "byteLength": 19696,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 498360,
      "byteLength": 23400,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 521760,
      "byteLength": 21888,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 543648,
      "byteLength": 13992,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 557640,
      "byteLength": 13992,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 571632,
      "byteLength": 9328,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 580960,
      "byteLength": 18656,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 599616,
      "byteLength": 9328,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 608944,
      "byteLength": 18192,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 627136,
      "byteLength": 8328,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 635464,
      "byteLength": 8328,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 643792,
      "byteLength": 5552,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 649344,
      "byteLength": 11104,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 660448,
      "byteLength": 5552,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 666000,
      "byteLength": 11136,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 677136,
      "byteLength": 5184,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 682320,
      "byteLength": 5184,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 687504,
      "byteLength": 3456,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 690960,
      "byteLength": 6912,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 697872,
      "byteLength": 3456,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 701328,
      "byteLength": 5568,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 706896,
      "byteLength": 27960,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 734856,
      "byteLength": 27960,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 762816,
      "byteLength": 18640,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 781456,
      "byteLength": 37280,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 818736,
      "byteLength": 18640,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 837376,
      "byteLength": 40080,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 877456,
      "byteLength": 3336,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 880792,
      "byteLength": 3336,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 884128,
      "byteLength": 2224,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 886352,
      "byteLength": 4448,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 890800,
      "byteLength": 2224,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 893024,
      "byteLength": 4992,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 898016,
      "byteLength": 3336,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 901352,
      "byteLength": 3336,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 904688,
      "byteLength": 3336,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 908024,
      "byteLength": 3336,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 911360,
      "byteLength": 3336,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 914696,
      "byteLength": 3336,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 918032,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 940760,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 963488,
      "byteLength": 15152,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 978640,
      "byteLength": 30304,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1008944,
      "byteLength": 15152,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1024096,
      "byteLength": 32208,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 1056304,
      "byteLength": 2472,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 1058776,
      "byteLength": 2472,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 1061248,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1083976,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1106704,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1129432,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1152160,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1174888,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1197616,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1220344,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1243072,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1265800,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1288528,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1311256,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1333984,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1356712,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1379440,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1402168,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1424896,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1447624,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1470352,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1493080,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1515808,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1538536,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1561264,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1583992,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1606720,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1629448,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1652176,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1674904,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1697632,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1720360,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1743088,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1765816,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1788544,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1811272,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1834000,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1856728,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1879456,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1902184,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1924912,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1947640,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1970368,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 1993096,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2015824,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2038552,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2061280,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2084008,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2106736,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2129464,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2152192,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2174920,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2197648,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2220376,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2243104,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2265832,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2288560,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2311288,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2334016,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2356744,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2379472,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2402200,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2424928,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2447656,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2470384,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2493112,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2515840,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2538568,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2561296,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2584024,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2606752,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2629480,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2652208,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2674936,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2697664,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2720392,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2743120,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2765848,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2788576,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2811304,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2834032,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2856760,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2879488,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2902216,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2924944,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2947672,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2970400,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 2993128,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3015856,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3038584,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3061312,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3084040,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3106768,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3129496,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3152224,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3174952,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3197680,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3220408,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3243136,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3265864,
      "byteLength": 22728,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3288592,
      "byteLength": 61848,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3350440,
      "byteLength": 61848,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3412288,
      "byteLength": 41232,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3453520,
      "byteLength": 82464,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3535984,
      "byteLength": 41232,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3577216,
      "byteLength": 69948,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 3647164,
      "byteLength": 3552,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 3650716,
      "byteLength": 14352,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 3665068,
      "byteLength": 468,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 3665536,
      "byteLength": 20844,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3686380,
      "byteLength": 20844,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3707224,
      "byteLength": 13896,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3721120,
      "byteLength": 27792,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3748912,
      "byteLength": 13896,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3762808,
      "byteLength": 28920,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 3791728,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3798352,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3804976,
      "byteLength": 4416,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3809392,
      "byteLength": 8832,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3818224,
      "byteLength": 4416,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3822640,
      "byteLength": 10056,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 3832696,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3839320,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3845944,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3852568,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3859192,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3865816,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3872440,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3879064,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3885688,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3892312,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3898936,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3905560,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3912184,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3918808,
      "byteLength": 6624,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3925432,
      "byteLength": 312,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3925744,
      "byteLength": 312,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3926056,
      "byteLength": 208,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3926264,
      "byteLength": 416,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3926680,
      "byteLength": 208,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3926888,
      "byteLength": 408,
      "target": 34963
    },
    {
      "buffer": 0,
      "byteOffset": 3927296,
      "byteLength": 312,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3927608,
      "byteLength": 312,
      "target": 34962
    },
    {
      "buffer": 0,
      "byteOffset": 3927920,
      "byteLength": 3968
    },
    {
      "buffer": 0,
      "byteOffset": 3931888,
      "byteLength": 1088
    },
    {
      "buffer": 0,
      "byteOffset": 3932976,
      "byteLength": 1856
    },
    {
      "buffer": 0,
      "byteOffset": 3934832,
      "byteLength": 1536
    },
    {
      "buffer": 0,
      "byteOffset": 3936368,
      "byteLength": 1408
    },
    {
      "buffer": 0,
      "byteOffset": 3937776,
      "byteLength": 1344
    },
    {
      "buffer": 0,
      "byteOffset": 3939120,
      "byteLength": 576
    },
    {
      "buffer": 0,
      "byteOffset": 3939696,
      "byteLength": 1408
    },
    {
      "buffer": 0,
      "byteOffset": 3941104,
      "byteLength": 2304
    },
    {
      "buffer": 0,
      "byteOffset": 3943408,
      "byteLength": 704
    },
    {
      "buffer": 0,
      "byteOffset": 3944112,
      "byteLength": 832
    },
    {
      "buffer": 0,
      "byteOffset": 3944944,
      "byteLength": 384
    }
  ],
  "accessors": [
    {
      "bufferView": 0,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 4804,
      "max": [
        0.614650965,
        1.31239367,
        0.150282308
      ],
      "min": [
        -0.614748538,
        0.9991788,
        -0.0840013
      ],
      "normalized": false
    },
    {
      "bufferView": 1,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 4804,
      "normalized": false
    },
    {
      "bufferView": 2,
      "byteOffset": 0,
      "type": "VEC2",
      "componentType": 5126,
      "count": 4804,
      "normalized": false
    },
    {
      "bufferView": 3,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5126,
      "count": 4804,
      "normalized": false
    },
    {
      "bufferView": 4,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5123,
      "count": 4804,
      "normalized": false
    },
    {
      "bufferView": 5,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 2574,
      "normalized": false
    },
    {
      "bufferView": 6,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 1170,
      "normalized": false
    },
    {
      "bufferView": 7,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 19122,
      "normalized": false
    },
    {
      "bufferView": 8,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 2462,
      "max": [
        0.1353521,
        1.06825089,
        0.07646791
      ],
      "min": [
        -0.135352015,
        -0.00138147641,
        -0.09597873
      ],
      "normalized": false
    },
    {
      "bufferView": 9,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 2462,
      "normalized": false
    },
    {
      "bufferView": 10,
      "byteOffset": 0,
      "type": "VEC2",
      "componentType": 5126,
      "count": 2462,
      "normalized": false
    },
    {
      "bufferView": 11,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5126,
      "count": 2462,
      "normalized": false
    },
    {
      "bufferView": 12,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5123,
      "count": 2462,
      "normalized": false
    },
    {
      "bufferView": 13,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 5850,
      "normalized": false
    },
    {
      "bufferView": 14,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 5472,
      "normalized": false
    },
    {
      "bufferView": 15,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1166,
      "max": [
        0.284764469,
        1.07174838,
        0.27100122
      ],
      "min": [
        -0.28476423,
        0.788560331,
        -0.275260985
      ],
      "normalized": false
    },
    {
      "bufferView": 16,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1166,
      "normalized": false
    },
    {
      "bufferView": 17,
      "byteOffset": 0,
      "type": "VEC2",
      "componentType": 5126,
      "count": 1166,
      "normalized": false
    },
    {
      "bufferView": 18,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5126,
      "count": 1166,
      "normalized": false
    },
    {
      "bufferView": 19,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5123,
      "count": 1166,
      "normalized": false
    },
    {
      "bufferView": 20,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 4548,
      "normalized": false
    },
    {
      "bufferView": 21,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 694,
      "max": [
        0.284764469,
        1.00637531,
        0.27100122
      ],
      "min": [
        -0.28476423,
        0.788560331,
        -0.275260985
      ],
      "normalized": false
    },
    {
      "bufferView": 22,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 694,
      "normalized": false
    },
    {
      "bufferView": 23,
      "byteOffset": 0,
      "type": "VEC2",
      "componentType": 5126,
      "count": 694,
      "normalized": false
    },
    {
      "bufferView": 24,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5126,
      "count": 694,
      "normalized": false
    },
    {
      "bufferView": 25,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5123,
      "count": 694,
      "normalized": false
    },
    {
      "bufferView": 26,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 2784,
      "normalized": false
    },
    {
      "bufferView": 27,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 432,
      "max": [
        0.2615382,
        0.947446346,
        0.229850471
      ],
      "min": [
        -0.261538,
        0.8208309,
        -0.2306574
      ],
      "normalized": false
    },
    {
      "bufferView": 28,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 432,
      "normalized": false
    },
    {
      "bufferView": 29,
      "byteOffset": 0,
      "type": "VEC2",
      "componentType": 5126,
      "count": 432,
      "normalized": false
    },
    {
      "bufferView": 30,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5126,
      "count": 432,
      "normalized": false
    },
    {
      "bufferView": 31,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5123,
      "count": 432,
      "normalized": false
    },
    {
      "bufferView": 32,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 1392,
      "normalized": false
    },
    {
      "bufferView": 33,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 2330,
      "max": [
        0.251627117,
        0.9088213,
        0.2297744
      ],
      "min": [
        -0.251626879,
        0.8375849,
        -0.231855482
      ],
      "normalized": false
    },
    {
      "bufferView": 34,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 2330,
      "normalized": false
    },
    {
      "bufferView": 35,
      "byteOffset": 0,
      "type": "VEC2",
      "componentType": 5126,
      "count": 2330,
      "normalized": false
    },
    {
      "bufferView": 36,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5126,
      "count": 2330,
      "normalized": false
    },
    {
      "bufferView": 37,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5123,
      "count": 2330,
      "normalized": false
    },
    {
      "bufferView": 38,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 10020,
      "normalized": false
    },
    {
      "bufferView": 39,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 278,
      "max": [
        0.0562642552,
        1.41165221,
        -0.0465810969
      ],
      "min": [
        -0.05625196,
        1.374128,
        -0.05600669
      ],
      "normalized": false
    },
    {
      "bufferView": 40,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 278,
      "normalized": false
    },
    {
      "bufferView": 41,
      "byteOffset": 0,
      "type": "VEC2",
      "componentType": 5126,
      "count": 278,
      "normalized": false
    },
    {
      "bufferView": 42,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5126,
      "count": 278,
      "normalized": false
    },
    {
      "bufferView": 43,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5123,
      "count": 278,
      "normalized": false
    },
    {
      "bufferView": 44,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 1248,
      "normalized": false
    },
    {
      "bufferView": 45,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 278,
      "max": [
        0,
        0,
        0.0499633551
      ],
      "min": [
        -2.23517418e-8,
        0,
        0
      ],
      "normalized": false
    },
    {
      "bufferView": 46,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 278,
      "normalized": false
    },
    {
      "bufferView": 47,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 278,
      "max": [
        0.0119137634,
        0.0150552988,
        0.003136374
      ],
      "min": [
        -0.01259331,
        -0.0149643421,
        -0.00410719961
      ],
      "normalized": false
    },
    {
      "bufferView": 48,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 278,
      "normalized": false
    },
    {
      "bufferView": 49,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 278,
      "max": [
        3.7252903e-9,
        0.00563061237,
        3.7252903e-9
      ],
      "min": [
        -7.450581e-9,
        -0.00548267365,
        -3.7252903e-9
      ],
      "normalized": false
    },
    {
      "bufferView": 50,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 278,
      "normalized": false
    },
    {
      "bufferView": 51,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.09598434,
        1.50164068,
        0.0548585579
      ],
      "min": [
        -0.0959843248,
        1.29767621,
        -0.08179742
      ],
      "normalized": false
    },
    {
      "bufferView": 52,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 53,
      "byteOffset": 0,
      "type": "VEC2",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 54,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 55,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5123,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 56,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 8052,
      "normalized": false
    },
    {
      "bufferView": 57,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 618,
      "normalized": false
    },
    {
      "bufferView": 58,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 618,
      "normalized": false
    },
    {
      "bufferView": 59,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.0085164085,
        0.00735485554,
        0.00656332262
      ],
      "min": [
        -0.0085164085,
        -0.008593917,
        -0.00536829233
      ],
      "normalized": false
    },
    {
      "bufferView": 60,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 61,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.00287998933,
        0.0021198988,
        0.000467404723
      ],
      "min": [
        -0.00287998933,
        -0.0016040802,
        -0.000385776162
      ],
      "normalized": false
    },
    {
      "bufferView": 62,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 63,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.00356108136,
        0.0142974854,
        0.00176388025
      ],
      "min": [
        -0.00356107764,
        -0.0048879385,
        -0.003128767
      ],
      "normalized": false
    },
    {
      "bufferView": 64,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 65,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.0085164085,
        0.00667691231,
        0.005496502
      ],
      "min": [
        -0.0085164085,
        -0.00597918034,
        -0.003628254
      ],
      "normalized": false
    },
    {
      "bufferView": 66,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 67,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.006493306,
        0.00735127926,
        0.00656332262
      ],
      "min": [
        -0.006493306,
        -0.008593917,
        -0.005403191
      ],
      "normalized": false
    },
    {
      "bufferView": 68,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 69,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.008516056,
        0.00763678551,
        0.009911656
      ],
      "min": [
        -0.008516056,
        -0.0133615732,
        -0.00528682768
      ],
      "normalized": false
    },
    {
      "bufferView": 70,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 71,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.000473162159,
        0.00000464916229,
        0.0001231134
      ],
      "min": [
        -0.000473162159,
        -0.00150930882,
        -4.172325e-7
      ],
      "normalized": false
    },
    {
      "bufferView": 72,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 73,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.000410005916,
        0.008916259,
        0.002732873
      ],
      "min": [
        -0.000410004985,
        -0.00613069534,
        -0.00433090329
      ],
      "normalized": false
    },
    {
      "bufferView": 74,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 75,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.000560253859,
        0.00216650963,
        0.000246673822
      ],
      "min": [
        -0.000560253859,
        -0.00302410126,
        -0.0005173832
      ],
      "normalized": false
    },
    {
      "bufferView": 76,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 77,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.009787708,
        0.008168578,
        0.005764995
      ],
      "min": [
        -0.009787713,
        -0.008683443,
        -0.00535053
      ],
      "normalized": false
    },
    {
      "bufferView": 78,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 79,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.009767706,
        0.00755524635,
        0.006050229
      ],
      "min": [
        -0.009767706,
        -0.0105911493,
        -0.00539559126
      ],
      "normalized": false
    },
    {
      "bufferView": 80,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 81,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.0107078394,
        0.009340167,
        0.00684313476
      ],
      "min": [
        -0.010707845,
        -0.0115611553,
        -0.005548626
      ],
      "normalized": false
    },
    {
      "bufferView": 82,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 83,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.006493306,
        0.00735127926,
        0.008382127
      ],
      "min": [
        -0.006493306,
        -0.009937286,
        -0.005406618
      ],
      "normalized": false
    },
    {
      "bufferView": 84,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 85,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.009708288,
        0.0109485388,
        0.0112130195
      ],
      "min": [
        -0.0105488291,
        -0.0139750242,
        -0.00636839867
      ],
      "normalized": false
    },
    {
      "bufferView": 86,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 87,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.001808296,
        0.00431954861,
        0.0000388026237
      ],
      "min": [
        -0.00180829782,
        -0.000219941139,
        -0.00237926841
      ],
      "normalized": false
    },
    {
      "bufferView": 88,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 89,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.0032323692,
        0.00219774246,
        0.000127792358
      ],
      "min": [
        -0.0032323692,
        -0.0004981756,
        -0.0007531047
      ],
      "normalized": false
    },
    {
      "bufferView": 90,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 91,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.00183208846,
        0.00493598,
        0.0000365376472
      ],
      "min": [
        -0.00676231,
        -0.000398755074,
        -0.00150871277
      ],
      "normalized": false
    },
    {
      "bufferView": 92,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 93,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.0002562441,
        0.00165188313,
        0.000054359436
      ],
      "min": [
        -0.000256245956,
        -0.000220894814,
        -0.000492155552
      ],
      "normalized": false
    },
    {
      "bufferView": 94,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 95,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.0007205317,
        0,
        0.0004900694
      ],
      "min": [
        -0.0007205289,
        -0.00183153152,
        -0.0002258569
      ],
      "normalized": false
    },
    {
      "bufferView": 96,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 97,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.00611607358,
        0.000184416771,
        0.00167584419
      ],
      "min": [
        -0.00611607358,
        -0.000945091248,
        0
      ],
      "normalized": false
    },
    {
      "bufferView": 98,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 99,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0,
        0.009265304,
        0.00109376013
      ],
      "min": [
        -2.79396772e-9,
        0,
        -0.000351846218
      ],
      "normalized": false
    },
    {
      "bufferView": 100,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 101,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.005575858,
        0.0022482872,
        0.021001894
      ],
      "min": [
        -0.005575871,
        -0.00356006622,
        0
      ],
      "normalized": false
    },
    {
      "bufferView": 102,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 103,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.007558454,
        0.00298821926,
        0.00187513232
      ],
      "min": [
        -0.007558452,
        -0.006023884,
        -0.003446117
      ],
      "normalized": false
    },
    {
      "bufferView": 104,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 105,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.009627238,
        0.0109801292,
        0.0158422
      ],
      "min": [
        -0.009626884,
        -0.0248082876,
        -0.0071259737
      ],
      "normalized": false
    },
    {
      "bufferView": 106,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 107,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.00302579254,
        0.00683891773,
        0.00279335678
      ],
      "min": [
        -0.00302579254,
        -0.0226329565,
        -0.001880385
      ],
      "normalized": false
    },
    {
      "bufferView": 108,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 109,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.004466459,
        0.0113426447,
        0.00256996229
      ],
      "min": [
        -0.00446644425,
        -0.0233750343,
        -0.00219547
      ],
      "normalized": false
    },
    {
      "bufferView": 110,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 111,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.00302579254,
        0.00683891773,
        0.00279335678
      ],
      "min": [
        -0.001565665,
        -0.0226329565,
        -0.00188037753
      ],
      "normalized": false
    },
    {
      "bufferView": 112,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 113,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.00156567246,
        0.00683891773,
        0.00279335678
      ],
      "min": [
        -0.00302579254,
        -0.0226329565,
        -0.001880385
      ],
      "normalized": false
    },
    {
      "bufferView": 114,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 115,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.004466459,
        0.0113426447,
        0.00256996229
      ],
      "min": [
        -0.00342043117,
        -0.0233750343,
        -0.00219546258
      ],
      "normalized": false
    },
    {
      "bufferView": 116,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 117,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.003420435,
        0.0113426447,
        0.00256996229
      ],
      "min": [
        -0.00446644425,
        -0.0233750343,
        -0.00219547
      ],
      "normalized": false
    },
    {
      "bufferView": 118,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 119,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.008099586,
        0.009336114,
        0.004020348
      ],
      "min": [
        -0.008099571,
        -0.0203638077,
        -0.00248895213
      ],
      "normalized": false
    },
    {
      "bufferView": 120,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 121,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.008272998,
        0.008515,
        0.003209293
      ],
      "min": [
        -0.008272983,
        -0.0230023861,
        -0.00308148935
      ],
      "normalized": false
    },
    {
      "bufferView": 122,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 123,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.000717911869,
        0.00578331947,
        9.23872e-7
      ],
      "min": [
        -0.000717923045,
        -0.0028898716,
        -7.450581e-9
      ],
      "normalized": false
    },
    {
      "bufferView": 124,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 125,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.0007295124,
        0.00009226799,
        0.000297669321
      ],
      "min": [
        -0.0007295124,
        -0.00679254532,
        -0.00025146082
      ],
      "normalized": false
    },
    {
      "bufferView": 126,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 127,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.00153684989,
        0.00324225426,
        9.685755e-8
      ],
      "min": [
        -0.00153684989,
        -0.002473116,
        -0.000009894371
      ],
      "normalized": false
    },
    {
      "bufferView": 128,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 129,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.0223596282,
        0.0104212761,
        0.0303843655
      ],
      "min": [
        -0.0223596133,
        -0.0220396519,
        -0.009873543
      ],
      "normalized": false
    },
    {
      "bufferView": 130,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 131,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.003932569,
        0,
        0
      ],
      "min": [
        -0.00393256545,
        -0.006852865,
        -0.000588148832
      ],
      "normalized": false
    },
    {
      "bufferView": 132,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 133,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.004645461,
        0.005958557,
        0.0002200976
      ],
      "min": [
        -0.003377108,
        -0.0103812218,
        -0.00275997072
      ],
      "normalized": false
    },
    {
      "bufferView": 134,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 135,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.003917657,
        0.00323140621,
        0.0009668991
      ],
      "min": [
        -0.00501265,
        -0.006019354,
        -0.000932067633
      ],
      "normalized": false
    },
    {
      "bufferView": 136,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 137,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.00854753,
        0.0005168915,
        3.7252903e-9
      ],
      "min": [
        -0.008896213,
        -0.0119826794,
        -0.004619658
      ],
      "normalized": false
    },
    {
      "bufferView": 138,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 139,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.000141344965,
        0.0200032,
        0
      ],
      "min": [
        0,
        0,
        -0.00246293843
      ],
      "normalized": false
    },
    {
      "bufferView": 140,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 141,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.000141352415,
        0,
        0.00169193
      ],
      "min": [
        0,
        -0.0143030882,
        0
      ],
      "normalized": false
    },
    {
      "bufferView": 142,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 143,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.0158872642,
        1.1920929e-7,
        0
      ],
      "min": [
        -0.0158872567,
        0,
        -0.006786391
      ],
      "normalized": false
    },
    {
      "bufferView": 144,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 145,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.00187393278,
        0.00640010834,
        0.0133938007
      ],
      "min": [
        -0.00187393278,
        -0.003680706,
        0
      ],
      "normalized": false
    },
    {
      "bufferView": 146,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 147,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.00121616572,
        0.003896594,
        0.00102128088
      ],
      "min": [
        -0.000287052244,
        -0.00528824329,
        -0.00117985532
      ],
      "normalized": false
    },
    {
      "bufferView": 148,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 149,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.000287052244,
        0.003896594,
        0.00102127343
      ],
      "min": [
        -0.00121617317,
        -0.00528824329,
        -0.00117986277
      ],
      "normalized": false
    },
    {
      "bufferView": 150,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 151,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.005635216,
        0.000931143761,
        0
      ],
      "min": [
        -0.00513223372,
        -0.00235319138,
        -0.0107447505
      ],
      "normalized": false
    },
    {
      "bufferView": 152,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 153,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0.00680250768,
        0.00451540947,
        0.00536165
      ],
      "min": [
        -0.00680251326,
        -0.00510561466,
        -0.00101718307
      ],
      "normalized": false
    },
    {
      "bufferView": 154,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 155,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "max": [
        0,
        0.00451302528,
        3.7252903e-9
      ],
      "min": [
        -1.86264515e-9,
        -0.0000258684158,
        -0.00000136345625
      ],
      "normalized": false
    },
    {
      "bufferView": 156,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1894,
      "normalized": false
    },
    {
      "bufferView": 157,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 5154,
      "max": [
        0.4830145,
        1.65024626,
        0.35808298
      ],
      "min": [
        -0.483016163,
        0.5962222,
        -0.09207976
      ],
      "normalized": false
    },
    {
      "bufferView": 158,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 5154,
      "normalized": false
    },
    {
      "bufferView": 159,
      "byteOffset": 0,
      "type": "VEC2",
      "componentType": 5126,
      "count": 5154,
      "normalized": false
    },
    {
      "bufferView": 160,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5126,
      "count": 5154,
      "normalized": false
    },
    {
      "bufferView": 161,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5123,
      "count": 5154,
      "normalized": false
    },
    {
      "bufferView": 162,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 17487,
      "normalized": false
    },
    {
      "bufferView": 163,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 888,
      "normalized": false
    },
    {
      "bufferView": 164,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 3588,
      "normalized": false
    },
    {
      "bufferView": 165,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 117,
      "normalized": false
    },
    {
      "bufferView": 166,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1737,
      "max": [
        0.0592891127,
        1.32359922,
        0.0344673619
      ],
      "min": [
        -0.0255812574,
        1.27195966,
        -0.0362685621
      ],
      "normalized": false
    },
    {
      "bufferView": 167,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 1737,
      "normalized": false
    },
    {
      "bufferView": 168,
      "byteOffset": 0,
      "type": "VEC2",
      "componentType": 5126,
      "count": 1737,
      "normalized": false
    },
    {
      "bufferView": 169,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5126,
      "count": 1737,
      "normalized": false
    },
    {
      "bufferView": 170,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5123,
      "count": 1737,
      "normalized": false
    },
    {
      "bufferView": 171,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 7230,
      "normalized": false
    },
    {
      "bufferView": 172,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "max": [
        0.0699274242,
        1.46955478,
        0.0159591362
      ],
      "min": [
        -0.06992744,
        1.35880721,
        -0.0446417443
      ],
      "normalized": false
    },
    {
      "bufferView": 173,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "normalized": false
    },
    {
      "bufferView": 174,
      "byteOffset": 0,
      "type": "VEC2",
      "componentType": 5126,
      "count": 552,
      "normalized": false
    },
    {
      "bufferView": 175,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5126,
      "count": 552,
      "normalized": false
    },
    {
      "bufferView": 176,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5123,
      "count": 552,
      "normalized": false
    },
    {
      "bufferView": 177,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 2514,
      "normalized": false
    },
    {
      "bufferView": 178,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "max": [
        0.0172306783,
        0,
        0
      ],
      "min": [
        -0.0172306225,
        -0.0105220079,
        -0.04102306
      ],
      "normalized": false
    },
    {
      "bufferView": 179,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "normalized": false
    },
    {
      "bufferView": 180,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "max": [
        0.0161353312,
        0.00404846668,
        0
      ],
      "min": [
        -0.0161352828,
        -0.00156843662,
        -0.03953631
      ],
      "normalized": false
    },
    {
      "bufferView": 181,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "normalized": false
    },
    {
      "bufferView": 182,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "max": [
        0.01472057,
        0.004731536,
        0
      ],
      "min": [
        -0.0147205144,
        -0.005308032,
        -0.03971529
      ],
      "normalized": false
    },
    {
      "bufferView": 183,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "normalized": false
    },
    {
      "bufferView": 184,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "max": [
        3.7252903e-9,
        0.00665199757,
        1.86264515e-9
      ],
      "min": [
        -3.7252903e-9,
        -0.00665199757,
        -3.7252903e-9
      ],
      "normalized": false
    },
    {
      "bufferView": 185,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "normalized": false
    },
    {
      "bufferView": 186,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "max": [
        0.00632623862,
        0,
        3.7252903e-9
      ],
      "min": [
        -0.00632622,
        0,
        -3.7252903e-9
      ],
      "normalized": false
    },
    {
      "bufferView": 187,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "normalized": false
    },
    {
      "bufferView": 188,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "max": [
        0.0223260969,
        0.0248373747,
        0
      ],
      "min": [
        -0.02232606,
        -0.0024677515,
        -0.0435117632
      ],
      "normalized": false
    },
    {
      "bufferView": 189,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "normalized": false
    },
    {
      "bufferView": 190,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "max": [
        0.00559313968,
        0.008445621,
        0
      ],
      "min": [
        -0.00559313968,
        0,
        -0.00757619366
      ],
      "normalized": false
    },
    {
      "bufferView": 191,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 552,
      "normalized": false
    },
    {
      "bufferView": 192,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 26,
      "max": [
        0.03850169,
        1.38318372,
        0.00530283572
      ],
      "min": [
        -0.03850164,
        1.35600936,
        -0.0167595111
      ],
      "normalized": false
    },
    {
      "bufferView": 193,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 26,
      "normalized": false
    },
    {
      "bufferView": 194,
      "byteOffset": 0,
      "type": "VEC2",
      "componentType": 5126,
      "count": 26,
      "normalized": false
    },
    {
      "bufferView": 195,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5126,
      "count": 26,
      "normalized": false
    },
    {
      "bufferView": 196,
      "byteOffset": 0,
      "type": "VEC4",
      "componentType": 5123,
      "count": 26,
      "normalized": false
    },
    {
      "bufferView": 197,
      "byteOffset": 0,
      "type": "SCALAR",
      "componentType": 5125,
      "count": 102,
      "normalized": false
    },
    {
      "bufferView": 198,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 26,
      "max": [
        0.0189977139,
        0.00629997253,
        -0.0560772121
      ],
      "min": [
        -0.0189976543,
        -0.007108569,
        -0.066963315
      ],
      "normalized": false
    },
    {
      "bufferView": 199,
      "byteOffset": 0,
      "type": "VEC3",
      "componentType": 5126,
      "count": 26,
      "normalized": false
    },
    {
      "bufferView": 200,
      "byteOffset": 0,
      "type": "MAT4",
      "componentType": 5126,
      "count": 62,
      "normalized": false
    },
    {
      "bufferView": 201,
      "byteOffset": 0,
      "type": "MAT4",
      "componentType": 5126,
      "count": 17,
      "normalized": false
    },
    {
      "bufferView": 202,
      "byteOffset": 0,
      "type": "MAT4",
      "componentType": 5126,
      "count": 29,
      "normalized": false
    },
    {
      "bufferView": 203,
      "byteOffset": 0,
      "type": "MAT4",
      "componentType": 5126,
      "count": 24,
      "normalized": false
    },
    {
      "bufferView": 204,
      "byteOffset": 0,
      "type": "MAT4",
      "componentType": 5126,
      "count": 22,
      "normalized": false
    },
    {
      "bufferView": 205,
      "byteOffset": 0,
      "type": "MAT4",
      "componentType": 5126,
      "count": 21,
      "normalized": false
    },
    {
      "bufferView": 206,
      "byteOffset": 0,
      "type": "MAT4",
      "componentType": 5126,
      "count": 9,
      "normalized": false
    },
    {
      "bufferView": 207,
      "byteOffset": 0,
      "type": "MAT4",
      "componentType": 5126,
      "count": 22,
      "normalized": false
    },
    {
      "bufferView": 208,
      "byteOffset": 0,
      "type": "MAT4",
      "componentType": 5126,
      "count": 36,
      "normalized": false
    },
    {
      "bufferView": 209,
      "byteOffset": 0,
      "type": "MAT4",
      "componentType": 5126,
      "count": 11,
      "normalized": false
    },
    {
      "bufferView": 210,
      "byteOffset": 0,
      "type": "MAT4",
      "componentType": 5126,
      "count": 13,
      "normalized": false
    },
    {
      "bufferView": 211,
      "byteOffset": 0,
      "type": "MAT4",
      "componentType": 5126,
      "count": 6,
      "normalized": false
    }
  ],
  "textures": [
    {
      "sampler": 0,
      "source": 0
    },
    {
      "sampler": 1,
      "source": 1
    },
    {
      "sampler": 2,
      "source": 2
    },
    {
      "sampler": 3,
      "source": 3
    },
    {
      "sampler": 4,
      "source": 4
    },
    {
      "sampler": 5,
      "source": 5
    },
    {
      "sampler": 6,
      "source": 6
    },
    {
      "sampler": 7,
      "source": 7
    }
  ],
  "samplers": [
    {
      "magFilter": 9729,
      "minFilter": 9729,
      "wrapS": 10497,
      "wrapT": 10497
    },
    {
      "magFilter": 9729,
      "minFilter": 9729,
      "wrapS": 10497,
      "wrapT": 10497
    },
    {
      "magFilter": 9729,
      "minFilter": 9729,
      "wrapS": 10497,
      "wrapT": 10497
    },
    {
      "magFilter": 9729,
      "minFilter": 9729,
      "wrapS": 10497,
      "wrapT": 10497
    },
    {
      "magFilter": 9729,
      "minFilter": 9729,
      "wrapS": 10497,
      "wrapT": 10497
    },
    {
      "magFilter": 9729,
      "minFilter": 9729,
      "wrapS": 10497,
      "wrapT": 10497
    },
    {
      "magFilter": 9729,
      "minFilter": 9729,
      "wrapS": 10497,
      "wrapT": 10497
    },
    {
      "magFilter": 9729,
      "minFilter": 9729,
      "wrapS": 10497,
      "wrapT": 10497
    }
  ],
  "images": [
    {
      "name": "Alicia_body",
      "uri": "AliciaSolid_vrm-0.51_img0.png"
    },
    {
      "name": "Sphere",
      "uri": "AliciaSolid_vrm-0.51_img1.png"
    },
    {
      "name": "Alicia_wear",
      "uri": "AliciaSolid_vrm-0.51_img2.png"
    },
    {
      "name": "Alicia_eye",
      "uri": "AliciaSolid_vrm-0.51_img3.png"
    },
    {
      "name": "Alicia_face",
      "uri": "AliciaSolid_vrm-0.51_img4.png"
    },
    {
      "name": "Alicia_hair",
      "uri": "AliciaSolid_vrm-0.51_img5.png"
    },
    {
      "name": "Alicia_other",
      "uri": "AliciaSolid_vrm-0.51_img6.png"
    },
    {
      "name": "Alicia",
      "uri": "AliciaSolid_vrm-0.51_img7.png"
    }
  ],
  "materials": [
    {
      "name": "Alicia_body",
      "pbrMetallicRoughness": {
        "baseColorTexture": {
          "index": 0,
          "texCoord": 0
        },
        "baseColorFactor": [
          1,
          1,
          1,
          1
        ],
        "metallicFactor": 0,
        "roughnessFactor": 0.9
      },
      "emissiveFactor": [
        0,
        0,
        0
      ],
      "alphaMode": "OPAQUE",
      "alphaCutoff": 0.5,
      "doubleSided": false,
      "extensions": {
        "KHR_materials_unlit": {}
      }
    },
    {
      "name": "Alicia_body_wear",
      "pbrMetallicRoughness": {
        "baseColorTexture": {
          "index": 0,
          "texCoord": 0
        },
        "baseColorFactor": [
          1,
          1,
          1,
          1
        ],
        "metallicFactor": 0,
        "roughnessFactor": 0.9
      },
      "emissiveFactor": [
        0,
        0,
        0
      ],
      "alphaMode": "OPAQUE",
      "alphaCutoff": 0.5,
      "doubleSided": false,
      "extensions": {
        "KHR_materials_unlit": {}
      }
    },
    {
      "name": "Alicia_wear",
      "pbrMetallicRoughness": {
        "baseColorTexture": {
          "index": 2,
          "texCoord": 0
        },
        "baseColorFactor": [
          1,
          1,
          1,
          1
        ],
        "metallicFactor": 0,
        "roughnessFactor": 0.9
      },
      "emissiveFactor": [
        0,
        0,
        0
      ],
      "alphaMode": "OPAQUE",
      "alphaCutoff": 0.5,
      "doubleSided": false,
      "extensions": {
        "KHR_materials_unlit": {}
      }
    },
    {
      "name": "Alicia_eye",
      "pbrMetallicRoughness": {
        "baseColorTexture": {
          "index": 3,
          "texCoord": 0
        },
        "baseColorFactor": [
          1,
          1,
          1,
          1
        ],
        "metallicFactor": 0,
        "roughnessFactor": 0.9
      },
      "emissiveFactor": [
        0,
        0,
        0
      ],
      "alphaMode": "OPAQUE",
      "alphaCutoff": 0.5,
      "doubleSided": false,
      "extensions": {
        "KHR_materials_unlit": {}
      }
    },
    {
      "name": "Alicia_face",
      "pbrMetallicRoughness": {
        "baseColorTexture": {
          "index": 4,
          "texCoord": 0
        },
        "baseColorFactor": [
          1,
          1,
          1,
          1
        ],
        "metallicFactor": 0,
        "roughnessFactor": 0.9
      },
      "emissiveFactor": [
        0,
        0,
        0
      ],
      "alphaMode": "OPAQUE",
      "alphaCutoff": 0.5,
      "doubleSided": false,
      "extensions": {
        "KHR_materials_unlit": {}
      }
    },
    {
      "name": "Alicia_eye_white",
      "pbrMetallicRoughness": {
        "baseColorTexture": {
          "index": 4,
          "texCoord": 0
        },
        "baseColorFactor": [
          1,
          1,
          1,
          1
        ],
        "metallicFactor": 0,
        "roughnessFactor": 0.9
      },
      "emissiveFactor": [
        0,
        0,
        0
      ],
      "alphaMode": "OPAQUE",
      "alphaCutoff": 0.5,
      "doubleSided": false,
      "extensions": {
        "KHR_materials_unlit": {}
      }
    },
    {
      "name": "Alicia_face_mastuge",
      "pbrMetallicRoughness": {
        "baseColorTexture": {
          "index": 4,
          "texCoord": 0
        },
        "baseColorFactor": [
          1,
          1,
          1,
          1
        ],
        "metallicFactor": 0,
        "roughnessFactor": 0.9
      },
      "emissiveFactor": [
        0,
        0,
        0
      ],
      "alphaMode": "BLEND",
      "alphaCutoff": 0.5,
      "doubleSided": false,
      "extensions": {
        "KHR_materials_unlit": {}
      }
    },
    {
      "name": "Alicia_hair",
      "pbrMetallicRoughness": {
        "baseColorTexture": {
          "index": 5,
          "texCoord": 0
        },
        "baseColorFactor": [
          1,
          1,
          1,
          1
        ],
        "metallicFactor": 0,
        "roughnessFactor": 0.9
      },
      "emissiveFactor": [
        0,
        0,
        0
      ],
      "alphaMode": "OPAQUE",
      "alphaCutoff": 0.5,
      "doubleSided": false,
      "extensions": {
        "KHR_materials_unlit": {}
      }
    },
    {
      "name": "Alicia_hair_trans_zwrite",
      "pbrMetallicRoughness": {
        "baseColorTexture": {
          "index": 5,
          "texCoord": 0
        },
        "baseColorFactor": [
          1,
          1,
          1,
          1
        ],
        "metallicFactor": 0,
        "roughnessFactor": 0.9
      },
      "emissiveFactor": [
        0,
        0,
        0
      ],
      "alphaMode": "BLEND",
      "alphaCutoff": 0.5,
      "doubleSided": false,
      "extensions": {
        "KHR_materials_unlit": {}
      }
    },
    {
      "name": "Alicia_hair_wear",
      "pbrMetallicRoughness": {
        "baseColorTexture": {
          "index": 5,
          "texCoord": 0
        },
        "baseColorFactor": [
          1,
          1,
          1,
          1
        ],
        "metallicFactor": 0,
        "roughnessFactor": 0.9
      },
      "emissiveFactor": [
        0,
        0,
        0
      ],
      "alphaMode": "OPAQUE",
      "alphaCutoff": 0.5,
      "doubleSided": false,
      "extensions": {
        "KHR_materials_unlit": {}
      }
    },
    {
      "name": "Alicia_hair_trans",
      "pbrMetallicRoughness": {
        "baseColorTexture": {
          "index": 5,
          "texCoord": 0
        },
        "baseColorFactor": [
          1,
          1,
          1,
          1
        ],
        "metallicFactor": 0,
        "roughnessFactor": 0.9
      },
      "emissiveFactor": [
        0,
        0,
        0
      ],
      "alphaMode": "BLEND",
      "alphaCutoff": 0.5,
      "doubleSided": false,
      "extensions": {
        "KHR_materials_unlit": {}
      }
    },
    {
      "name": "Alicia_other_zwrite",
      "pbrMetallicRoughness": {
        "baseColorTexture": {
          "index": 6,
          "texCoord": 0
        },
        "baseColorFactor": [
          1,
          1,
          1,
          1
        ],
        "metallicFactor": 0,
        "roughnessFactor": 0.9
      },
      "emissiveFactor": [
        0,
        0,
        0
      ],
      "alphaMode": "BLEND",
      "alphaCutoff": 0.5,
      "doubleSided": false,
      "extensions": {
        "KHR_materials_unlit": {}
      }
    }
  ],
  "meshes": [
    {
      "name": "body_top.baked",
      "primitives": [
        {
          "mode": 4,
          "indices": 5,
          "attributes": {
            "POSITION": 0,
            "NORMAL": 1,
            "TEXCOORD_0": 2,
            "JOINTS_0": 4,
            "WEIGHTS_0": 3
          },
          "material": 0
        },
        {
          "mode": 4,
          "indices": 6,
          "attributes": {
            "POSITION": 0,
            "NORMAL": 1,
            "TEXCOORD_0": 2,
            "JOINTS_0": 4,
            "WEIGHTS_0": 3
          },
          "material": 1
        },
        {
          "mode": 4,
          "indices": 7,
          "attributes": {
            "POSITION": 0,
            "NORMAL": 1,
            "TEXCOORD_0": 2,
            "JOINTS_0": 4,
            "WEIGHTS_0": 3
          },
          "material": 2
        }
      ]
    },
    {
      "name": "body_under.baked",
      "primitives": [
        {
          "mode": 4,
          "indices": 13,
          "attributes": {
            "POSITION": 8,
            "NORMAL": 9,
            "TEXCOORD_0": 10,
            "JOINTS_0": 12,
            "WEIGHTS_0": 11
          },
          "material": 0
        },
        {
          "mode": 4,
          "indices": 14,
          "attributes": {
            "POSITION": 8,
            "NORMAL": 9,
            "TEXCOORD_0": 10,
            "JOINTS_0": 12,
            "WEIGHTS_0": 11
          },
          "material": 2
        }
      ]
    },
    {
      "name": "cloth.baked",
      "primitives": [
        {
          "mode": 4,
          "indices": 20,
          "attributes": {
            "POSITION": 15,
            "NORMAL": 16,
            "TEXCOORD_0": 17,
            "JOINTS_0": 19,
            "WEIGHTS_0": 18
          },
          "material": 2
        }
      ]
    },
    {
      "name": "cloth1.baked",
      "primitives": [
        {
          "mode": 4,
          "indices": 26,
          "attributes": {
            "POSITION": 21,
            "NORMAL": 22,
            "TEXCOORD_0": 23,
            "JOINTS_0": 25,
            "WEIGHTS_0": 24
          },
          "material": 2
        }
      ]
    },
    {
      "name": "cloth2.baked",
      "primitives": [
        {
          "mode": 4,
          "indices": 32,
          "attributes": {
            "POSITION": 27,
            "NORMAL": 28,
            "TEXCOORD_0": 29,
            "JOINTS_0": 31,
            "WEIGHTS_0": 30
          },
          "material": 2
        }
      ]
    },
    {
      "name": "cloth_ribbon.baked",
      "primitives": [
        {
          "mode": 4,
          "indices": 38,
          "attributes": {
            "POSITION": 33,
            "NORMAL": 34,
            "TEXCOORD_0": 35,
            "JOINTS_0": 37,
            "WEIGHTS_0": 36
          },
          "material": 2
        }
      ]
    },
    {
      "name": "eye.baked",
      "primitives": [
        {
          "mode": 4,
          "indices": 44,
          "attributes": {
            "POSITION": 39,
            "NORMAL": 40,
            "TEXCOORD_0": 41,
            "JOINTS_0": 43,
            "WEIGHTS_0": 42
          },
          "material": 3,
          "targets": [
            {
              "POSITION": 45,
              "NORMAL": 46
            },
            {
              "POSITION": 47,
              "NORMAL": 48
            },
            {
              "POSITION": 49,
              "NORMAL": 50
            }
          ],
          "extras": {
            "targetNames": [
              "bs_eye.noHilighnt",
              "bs_eye.seyeMin",
              "bs_eye.seyeRound"
            ]
          }
        }
      ]
    },
    {
      "name": "face.baked",
      "primitives": [
        {
          "mode": 4,
          "indices": 56,
          "attributes": {
            "POSITION": 51,
            "NORMAL": 52,
            "TEXCOORD_0": 53,
            "JOINTS_0": 55,
            "WEIGHTS_0": 54
          },
          "material": 4,
          "targets": [
            {
              "POSITION": 59,
              "NORMAL": 60
            },
            {
              "POSITION": 61,
              "NORMAL": 62
            },
            {
              "POSITION": 63,
              "NORMAL": 64
            },
            {
              "POSITION": 65,
              "NORMAL": 66
            },
            {
              "POSITION": 67,
              "NORMAL": 68
            },
            {
              "POSITION": 69,
              "NORMAL": 70
            },
            {
              "POSITION": 71,
              "NORMAL": 72
            },
            {
              "POSITION": 73,
              "NORMAL": 74
            },
            {
              "POSITION": 75,
              "NORMAL": 76
            },
            {
              "POSITION": 77,
              "NORMAL": 78
            },
            {
              "POSITION": 79,
              "NORMAL": 80
            },
            {
              "POSITION": 81,
              "NORMAL": 82
            },
            {
              "POSITION": 83,
              "NORMAL": 84
            },
            {
              "POSITION": 85,
              "NORMAL": 86
            },
            {
              "POSITION": 87,
              "NORMAL": 88
            },
            {
              "POSITION": 89,
              "NORMAL": 90
            },
            {
              "POSITION": 91,
              "NORMAL": 92
            },
            {
              "POSITION": 93,
              "NORMAL": 94
            },
            {
              "POSITION": 95,
              "NORMAL": 96
            },
            {
              "POSITION": 97,
              "NORMAL": 98
            },
            {
              "POSITION": 99,
              "NORMAL": 100
            },
            {
              "POSITION": 101,
              "NORMAL": 102
            },
            {
              "POSITION": 103,
              "NORMAL": 104
            },
            {
              "POSITION": 105,
              "NORMAL": 106
            },
            {
              "POSITION": 107,
              "NORMAL": 108
            },
            {
              "POSITION": 109,
              "NORMAL": 110
            },
            {
              "POSITION": 111,
              "NORMAL": 112
            },
            {
              "POSITION": 113,
              "NORMAL": 114
            },
            {
              "POSITION": 115,
              "NORMAL": 116
            },
            {
              "POSITION": 117,
              "NORMAL": 118
            },
            {
              "POSITION": 119,
              "NORMAL": 120
            },
            {
              "POSITION": 121,
              "NORMAL": 122
            },
            {
              "POSITION": 123,
              "NORMAL": 124
            },
            {
              "POSITION": 125,
              "NORMAL": 126
            },
            {
              "POSITION": 127,
              "NORMAL": 128
            },
            {
              "POSITION": 129,
              "NORMAL": 130
            },
            {
              "POSITION": 131,
              "NORMAL": 132
            },
            {
              "POSITION": 133,
              "NORMAL": 134
            },
            {
              "POSITION": 135,
              "NORMAL": 136
            },
            {
              "POSITION": 137,
              "NORMAL": 138
            },
            {
              "POSITION": 139,
              "NORMAL": 140
            },
            {
              "POSITION": 141,
              "NORMAL": 142
            },
            {
              "POSITION": 143,
              "NORMAL": 144
            },
            {
              "POSITION": 145,
              "NORMAL": 146
            },
            {
              "POSITION": 147,
              "NORMAL": 148
            },
            {
              "POSITION": 149,
              "NORMAL": 150
            },
            {
              "POSITION": 151,
              "NORMAL": 152
            },
            {
              "POSITION": 153,
              "NORMAL": 154
            },
            {
              "POSITION": 155,
              "NORMAL": 156
            }
          ],
          "extras": {
            "targetNames": [
              "bs_face.mouth_a",
              "bs_face.mouth_i",
              "bs_face.mouth_u",
              "bs_face.mouth_e",
              "bs_face.mouth_o",
              "bs_face.mouth_a2",
              "bs_face.mouth_n",
              "bs_face.mouth_Triangle",
              "bs_face.mouth_lambda",
              "bs_face.mouth_Square",
              "bs_face.mouth_wa",
              "bs_face.mouth_wa2",
              "bs_face.mouth_shock",
              "bs_face.mouth_angry",
              "bs_face.mouth_smile",
              "bs_face.mouth_spear",
              "bs_face.mouth_spear2",
              "bs_face.mouth_ornerUp",
              "bs_face.mouth_cornerDown",
              "bs_face.mouth_cornerSpread",
              "bs_face.mouth_noTeethUp",
              "bs_face.mouth_noTeethDown",
              "bs_face.mouth_Tu",
              "bs_face.mouth_be",
              "bs_face.eye_blink",
              "bs_face.eye_smile",
              "bs_face.eye_winkL",
              "bs_face.eye_winkR",
              "bs_face.eye_winkL2",
              "bs_face.eye_winkR2",
              "bs_face.eye_Calm",
              "bs_face.eye___Shape",
              "bs_face.eye_surprised",
              "bs_face.eye_TT",
              "bs_face.eye_serious",
              "bs_face.eye_none",
              "bs_face.eyebrow_serious",
              "bs_face.eyebrow_trouble",
              "bs_face.eyeblow_smile",
              "bs_face.eyeblow_angry",
              "bs_face.eyeblow_up",
              "bs_face.eyeblow_down",
              "bs_face.eyeblow_gather",
              "bs_face.sface_view",
              "bs_face.sface_right",
              "bs_face.sface_left",
              "bs_face.tongue",
              "bs_face.mouth_mortifying",
              "bs_face.eye_up"
            ]
          }
        },
        {
          "mode": 4,
          "indices": 57,
          "attributes": {
            "POSITION": 51,
            "NORMAL": 52,
            "TEXCOORD_0": 53,
            "JOINTS_0": 55,
            "WEIGHTS_0": 54
          },
          "material": 5,
          "targets": [
            {
              "POSITION": 59,
              "NORMAL": 60
            },
            {
              "POSITION": 61,
              "NORMAL": 62
            },
            {
              "POSITION": 63,
              "NORMAL": 64
            },
            {
              "POSITION": 65,
              "NORMAL": 66
            },
            {
              "POSITION": 67,
              "NORMAL": 68
            },
            {
              "POSITION": 69,
              "NORMAL": 70
            },
            {
              "POSITION": 71,
              "NORMAL": 72
            },
            {
              "POSITION": 73,
              "NORMAL": 74
            },
            {
              "POSITION": 75,
              "NORMAL": 76
            },
            {
              "POSITION": 77,
              "NORMAL": 78
            },
            {
              "POSITION": 79,
              "NORMAL": 80
            },
            {
              "POSITION": 81,
              "NORMAL": 82
            },
            {
              "POSITION": 83,
              "NORMAL": 84
            },
            {
              "POSITION": 85,
              "NORMAL": 86
            },
            {
              "POSITION": 87,
              "NORMAL": 88
            },
            {
              "POSITION": 89,
              "NORMAL": 90
            },
            {
              "POSITION": 91,
              "NORMAL": 92
            },
            {
              "POSITION": 93,
              "NORMAL": 94
            },
            {
              "POSITION": 95,
              "NORMAL": 96
            },
            {
              "POSITION": 97,
              "NORMAL": 98
            },
            {
              "POSITION": 99,
              "NORMAL": 100
            },
            {
              "POSITION": 101,
              "NORMAL": 102
            },
            {
              "POSITION": 103,
              "NORMAL": 104
            },
            {
              "POSITION": 105,
              "NORMAL": 106
            },
            {
              "POSITION": 107,
              "NORMAL": 108
            },
            {
              "POSITION": 109,
              "NORMAL": 110
            },
            {
              "POSITION": 111,
              "NORMAL": 112
            },
            {
              "POSITION": 113,
              "NORMAL": 114
            },
            {
              "POSITION": 115,
              "NORMAL": 116
            },
            {
              "POSITION": 117,
              "NORMAL": 118
            },
            {
              "POSITION": 119,
              "NORMAL": 120
            },
            {
              "POSITION": 121,
              "NORMAL": 122
            },
            {
              "POSITION": 123,
              "NORMAL": 124
            },
            {
              "POSITION": 125,
              "NORMAL": 126
            },
            {
              "POSITION": 127,
              "NORMAL": 128
            },
            {
              "POSITION": 129,
              "NORMAL": 130
            },
            {
              "POSITION": 131,
              "NORMAL": 132
            },
            {
              "POSITION": 133,
              "NORMAL": 134
            },
            {
              "POSITION": 135,
              "NORMAL": 136
            },
            {
              "POSITION": 137,
              "NORMAL": 138
            },
            {
              "POSITION": 139,
              "NORMAL": 140
            },
            {
              "POSITION": 141,
              "NORMAL": 142
            },
            {
              "POSITION": 143,
              "NORMAL": 144
            },
            {
              "POSITION": 145,
              "NORMAL": 146
            },
            {
              "POSITION": 147,
              "NORMAL": 148
            },
            {
              "POSITION": 149,
              "NORMAL": 150
            },
            {
              "POSITION": 151,
              "NORMAL": 152
            },
            {
              "POSITION": 153,
              "NORMAL": 154
            },
            {
              "POSITION": 155,
              "NORMAL": 156
            }
          ],
          "extras": {
            "targetNames": [
              "bs_face.mouth_a",
              "bs_face.mouth_i",
              "bs_face.mouth_u",
              "bs_face.mouth_e",
              "bs_face.mouth_o",
              "bs_face.mouth_a2",
              "bs_face.mouth_n",
              "bs_face.mouth_Triangle",
              "bs_face.mouth_lambda",
              "bs_face.mouth_Square",
              "bs_face.mouth_wa",
              "bs_face.mouth_wa2",
              "bs_face.mouth_shock",
              "bs_face.mouth_angry",
              "bs_face.mouth_smile",
              "bs_face.mouth_spear",
              "bs_face.mouth_spear2",
              "bs_face.mouth_ornerUp",
              "bs_face.mouth_cornerDown",
              "bs_face.mouth_cornerSpread",
              "bs_face.mouth_noTeethUp",
              "bs_face.mouth_noTeethDown",
              "bs_face.mouth_Tu",
              "bs_face.mouth_be",
              "bs_face.eye_blink",
              "bs_face.eye_smile",
              "bs_face.eye_winkL",
              "bs_face.eye_winkR",
              "bs_face.eye_winkL2",
              "bs_face.eye_winkR2",
              "bs_face.eye_Calm",
              "bs_face.eye___Shape",
              "bs_face.eye_surprised",
              "bs_face.eye_TT",
              "bs_face.eye_serious",
              "bs_face.eye_none",
              "bs_face.eyebrow_serious",
              "bs_face.eyebrow_trouble",
              "bs_face.eyeblow_smile",
              "bs_face.eyeblow_angry",
              "bs_face.eyeblow_up",
              "bs_face.eyeblow_down",
              "bs_face.eyeblow_gather",
              "bs_face.sface_view",
              "bs_face.sface_right",
              "bs_face.sface_left",
              "bs_face.tongue",
              "bs_face.mouth_mortifying",
              "bs_face.eye_up"
            ]
          }
        },
        {
          "mode": 4,
          "indices": 58,
          "attributes": {
            "POSITION": 51,
            "NORMAL": 52,
            "TEXCOORD_0": 53,
            "JOINTS_0": 55,
            "WEIGHTS_0": 54
          },
          "material": 6,
          "targets": [
            {
              "POSITION": 59,
              "NORMAL": 60
            },
            {
              "POSITION": 61,
              "NORMAL": 62
            },
            {
              "POSITION": 63,
              "NORMAL": 64
            },
            {
              "POSITION": 65,
              "NORMAL": 66
            },
            {
              "POSITION": 67,
              "NORMAL": 68
            },
            {
              "POSITION": 69,
              "NORMAL": 70
            },
            {
              "POSITION": 71,
              "NORMAL": 72
            },
            {
              "POSITION": 73,
              "NORMAL": 74
            },
            {
              "POSITION": 75,
              "NORMAL": 76
            },
            {
              "POSITION": 77,
              "NORMAL": 78
            },
            {
              "POSITION": 79,
              "NORMAL": 80
            },
            {
              "POSITION": 81,
              "NORMAL": 82
            },
            {
              "POSITION": 83,
              "NORMAL": 84
            },
            {
              "POSITION": 85,
              "NORMAL": 86
            },
            {
              "POSITION": 87,
              "NORMAL": 88
            },
            {
              "POSITION": 89,
              "NORMAL": 90
            },
            {
              "POSITION": 91,
              "NORMAL": 92
            },
            {
              "POSITION": 93,
              "NORMAL": 94
            },
            {
              "POSITION": 95,
              "NORMAL": 96
            },
            {
              "POSITION": 97,
              "NORMAL": 98
            },
            {
              "POSITION": 99,
              "NORMAL": 100
            },
            {
              "POSITION": 101,
              "NORMAL": 102
            },
            {
              "POSITION": 103,
              "NORMAL": 104
            },
            {
              "POSITION": 105,
              "NORMAL": 106
            },
            {
              "POSITION": 107,
              "NORMAL": 108
            },
            {
              "POSITION": 109,
              "NORMAL": 110
            },
            {
              "POSITION": 111,
              "NORMAL": 112
            },
            {
              "POSITION": 113,
              "NORMAL": 114
            },
            {
              "POSITION": 115,
              "NORMAL": 116
            },
            {
              "POSITION": 117,
              "NORMAL": 118
            },
            {
              "POSITION": 119,
              "NORMAL": 120
            },
            {
              "POSITION": 121,
              "NORMAL": 122
            },
            {
              "POSITION": 123,
              "NORMAL": 124
            },
            {
              "POSITION": 125,
              "NORMAL": 126
            },
            {
              "POSITION": 127,
              "NORMAL": 128
            },
            {
              "POSITION": 129,
              "NORMAL": 130
            },
            {
              "POSITION": 131,
              "NORMAL": 132
            },
            {
              "POSITION": 133,
              "NORMAL": 134
            },
            {
              "POSITION": 135,
              "NORMAL": 136
            },
            {
              "POSITION": 137,
              "NORMAL": 138
            },
            {
              "POSITION": 139,
              "NORMAL": 140
            },
            {
              "POSITION": 141,
              "NORMAL": 142
            },
            {
              "POSITION": 143,
              "NORMAL": 144
            },
            {
              "POSITION": 145,
              "NORMAL": 146
            },
            {
              "POSITION": 147,
              "NORMAL": 148
            },
            {
              "POSITION": 149,
              "NORMAL": 150
            },
            {
              "POSITION": 151,
              "NORMAL": 152
            },
            {
              "POSITION": 153,
              "NORMAL": 154
            },
            {
              "POSITION": 155,
              "NORMAL": 156
            }
          ],
          "extras": {
            "targetNames": [
              "bs_face.mouth_a",
              "bs_face.mouth_i",
              "bs_face.mouth_u",
              "bs_face.mouth_e",
              "bs_face.mouth_o",
              "bs_face.mouth_a2",
              "bs_face.mouth_n",
              "bs_face.mouth_Triangle",
              "bs_face.mouth_lambda",
              "bs_face.mouth_Square",
              "bs_face.mouth_wa",
              "bs_face.mouth_wa2",
              "bs_face.mouth_shock",
              "bs_face.mouth_angry",
              "bs_face.mouth_smile",
              "bs_face.mouth_spear",
              "bs_face.mouth_spear2",
              "bs_face.mouth_ornerUp",
              "bs_face.mouth_cornerDown",
              "bs_face.mouth_cornerSpread",
              "bs_face.mouth_noTeethUp",
              "bs_face.mouth_noTeethDown",
              "bs_face.mouth_Tu",
              "bs_face.mouth_be",
              "bs_face.eye_blink",
              "bs_face.eye_smile",
              "bs_face.eye_winkL",
              "bs_face.eye_winkR",
              "bs_face.eye_winkL2",
              "bs_face.eye_winkR2",
              "bs_face.eye_Calm",
              "bs_face.eye___Shape",
              "bs_face.eye_surprised",
              "bs_face.eye_TT",
              "bs_face.eye_serious",
              "bs_face.eye_none",
              "bs_face.eyebrow_serious",
              "bs_face.eyebrow_trouble",
              "bs_face.eyeblow_smile",
              "bs_face.eyeblow_angry",
              "bs_face.eyeblow_up",
              "bs_face.eyeblow_down",
              "bs_face.eyeblow_gather",
              "bs_face.sface_view",
              "bs_face.sface_right",
              "bs_face.sface_left",
              "bs_face.tongue",
              "bs_face.mouth_mortifying",
              "bs_face.eye_up"
            ]
          }
        }
      ]
    },
    {
      "name": "flonthair.baked",
      "primitives": [
        {
          "mode": 4,
          "indices": 162,
          "attributes": {
            "POSITION": 157,
            "NORMAL": 158,
            "TEXCOORD_0": 159,
            "JOINTS_0": 161,
            "WEIGHTS_0": 160
          },
          "material": 7
        },
        {
          "mode": 4,
          "indices": 163,
          "attributes": {
            "POSITION": 157,
            "NORMAL": 158,
            "TEXCOORD_0": 159,
            "JOINTS_0": 161,
            "WEIGHTS_0": 160
          },
          "material": 8
        },
        {
          "mode": 4,
          "indices": 164,
          "attributes": {
            "POSITION": 157,
            "NORMAL": 158,
            "TEXCOORD_0": 159,
            "JOINTS_0": 161,
            "WEIGHTS_0": 160
          },
          "material": 9
        },
        {
          "mode": 4,
          "indices": 165,
          "attributes": {
            "POSITION": 157,
            "NORMAL": 158,
            "TEXCOORD_0": 159,
            "JOINTS_0": 161,
            "WEIGHTS_0": 160
          },
          "material": 10
        }
      ]
    },
    {
      "name": "neck.baked",
      "primitives": [
        {
          "mode": 4,
          "indices": 171,
          "attributes": {
            "POSITION": 166,
            "NORMAL": 167,
            "TEXCOORD_0": 168,
            "JOINTS_0": 170,
            "WEIGHTS_0": 169
          },
          "material": 1
        }
      ]
    },
    {
      "name": "other.baked",
      "primitives": [
        {
          "mode": 4,
          "indices": 177,
          "attributes": {
            "POSITION": 172,
            "NORMAL": 173,
            "TEXCOORD_0": 174,
            "JOINTS_0": 176,
            "WEIGHTS_0": 175
          },
          "material": 11,
          "targets": [
            {
              "POSITION": 178,
              "NORMAL": 179
            },
            {
              "POSITION": 180,
              "NORMAL": 181
            },
            {
              "POSITION": 182,
              "NORMAL": 183
            },
            {
              "POSITION": 184,
              "NORMAL": 185
            },
            {
              "POSITION": 186,
              "NORMAL": 187
            },
            {
              "POSITION": 188,
              "NORMAL": 189
            },
            {
              "POSITION": 190,
              "NORMAL": 191
            }
          ],
          "extras": {
            "targetNames": [
              "bs_other1.sother_shy",
              "bs_other1.eye___2Shape",
              "bs_other1.eye_h1",
              "bs_other1.eye_h2",
              "bs_other1.eye_h3",
              "bs_other1.oher_shocked",
              "bs_other1.sother_tear"
            ]
          }
        }
      ]
    },
    {
      "name": "other02.baked",
      "primitives": [
        {
          "mode": 4,
          "indices": 197,
          "attributes": {
            "POSITION": 192,
            "NORMAL": 193,
            "TEXCOORD_0": 194,
            "JOINTS_0": 196,
            "WEIGHTS_0": 195
          },
          "material": 11,
          "targets": [
            {
              "POSITION": 198,
              "NORMAL": 199
            }
          ],
          "extras": {
            "targetNames": [
              "bs_other2.other_shy2"
            ]
          }
        }
      ]
    }
  ],
  "nodes": [
    {
      "name": "mesh",
      "children": [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        11,
        12
      ],
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "body_top",
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "mesh": 0,
      "skin": 0,
      "extras": {}
    },
    {
      "name": "body_under",
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "mesh": 1,
      "skin": 1,
      "extras": {}
    },
    {
      "name": "cloth",
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "mesh": 2,
      "skin": 2,
      "extras": {}
    },
    {
      "name": "cloth1",
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "mesh": 3,
      "skin": 3,
      "extras": {}
    },
    {
      "name": "cloth2",
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "mesh": 4,
      "skin": 4,
      "extras": {}
    },
    {
      "name": "cloth_ribbon",
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "mesh": 5,
      "skin": 5,
      "extras": {}
    },
    {
      "name": "eye",
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "mesh": 6,
      "skin": 6,
      "extras": {}
    },
    {
      "name": "face",
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "mesh": 7,
      "skin": 7,
      "extras": {}
    },
    {
      "name": "flonthair",
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "mesh": 8,
      "skin": 8,
      "extras": {}
    },
    {
      "name": "neck",
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "mesh": 9,
      "skin": 9,
      "extras": {}
    },
    {
      "name": "other",
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "mesh": 10,
      "skin": 10,
      "extras": {}
    },
    {
      "name": "other02",
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "mesh": 11,
      "skin": 11,
      "extras": {}
    },
    {
      "name": "Root",
      "children": [
        14
      ],
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "Hips",
      "children": [
        15,
        20,
        25,
        27,
        29,
        31,
        33,
        35,
        37,
        39,
        41,
        43,
        45
      ],
      "translation": [
        0,
        0.9714602,
        -2.157075e-16
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftUpLeg",
      "children": [
        16
      ],
      "translation": [
        -0.0603868179,
        -0.08547634,
        -0.0009169821
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftLeg",
      "children": [
        17
      ],
      "translation": [
        0.00672503561,
        -0.36331898,
        -0.00135944458
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftFoot",
      "children": [
        18
      ],
      "translation": [
        0.0125253089,
        -0.4195072,
        0.020169124
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftToeBase",
      "children": [
        19
      ],
      "translation": [
        0.00343400985,
        -0.0830073357,
        -0.07748183
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftToeEnd",
      "translation": [
        0.000005055219,
        0.00022405386,
        -0.0199987441
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightUpLeg",
      "children": [
        21
      ],
      "translation": [
        0.0603888966,
        -0.08547634,
        -0.0009169821
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightLeg",
      "children": [
        22
      ],
      "translation": [
        -0.00672556832,
        -0.36331898,
        -0.00135965785
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightFoot",
      "children": [
        23
      ],
      "translation": [
        -0.0125266016,
        -0.4195072,
        0.020168893
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightToeBase",
      "children": [
        24
      ],
      "translation": [
        -0.00343461335,
        -0.0830073357,
        -0.07748197
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightToeEnd",
      "translation": [
        -0.00000512599945,
        0.000224232674,
        -0.0199987441
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_01_01",
      "children": [
        26
      ],
      "translation": [
        0,
        0.0165770054,
        -0.08697255
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_01_02",
      "translation": [
        0,
        -0.15033704,
        -0.06422062
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_02_01",
      "children": [
        28
      ],
      "translation": [
        -0.06666802,
        0.0115950108,
        -0.0718427151
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_02_02",
      "translation": [
        -0.05006849,
        -0.1416943,
        -0.0535511523
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_03_01",
      "children": [
        30
      ],
      "translation": [
        -0.1002169,
        0.0139329433,
        -0.0256661512
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_03_02",
      "translation": [
        -0.0766223744,
        -0.136800647,
        -0.01205324
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_04_01",
      "children": [
        32
      ],
      "translation": [
        -0.0933305249,
        0.0133851171,
        0.02364521
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_04_02",
      "translation": [
        -0.07473818,
        -0.1285215,
        0.0375104845
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_05_01",
      "children": [
        34
      ],
      "translation": [
        -0.0537137575,
        0.0133851171,
        0.06501952
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_05_02",
      "translation": [
        -0.0445548855,
        -0.128521442,
        0.07076508
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_06_01",
      "children": [
        36
      ],
      "translation": [
        1.027122e-8,
        0.009088278,
        0.0850500539
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_06_02",
      "translation": [
        0,
        -0.128521562,
        0.08362313
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_07_01",
      "children": [
        38
      ],
      "translation": [
        0.05371,
        0.0133851767,
        0.06501949
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_07_02",
      "translation": [
        0.04455483,
        -0.128521383,
        0.07076515
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_08_01",
      "children": [
        40
      ],
      "translation": [
        0.09333,
        0.0133851767,
        0.0236452185
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_08_02",
      "translation": [
        0.07473817,
        -0.128521383,
        0.03751055
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_09_01",
      "children": [
        42
      ],
      "translation": [
        0.10022,
        0.0139329433,
        -0.02566616
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_09_02",
      "translation": [
        0.07662233,
        -0.136800647,
        -0.0120532867
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_10_01",
      "children": [
        44
      ],
      "translation": [
        0.06666999,
        0.0115950108,
        -0.0718426853
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "skirt_10_02",
      "translation": [
        0.0500685573,
        -0.141694188,
        -0.05355124
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "Spine",
      "children": [
        46
      ],
      "translation": [
        0,
        0.0127167106,
        -0.01323
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "Spine1",
      "children": [
        47
      ],
      "translation": [
        0,
        0.0562785268,
        -0.0006406186
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "Spine2",
      "children": [
        48
      ],
      "translation": [
        1.05656559e-8,
        0.0443155766,
        0.0009871088
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "Spine3",
      "children": [
        49,
        74,
        115,
        140,
        141
      ],
      "translation": [
        1.0794337e-8,
        0.0452747345,
        -0.000346527435
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftShoulder",
      "children": [
        50
      ],
      "translation": [
        -0.0164333079,
        0.137162089,
        0.0226079449
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftArm",
      "children": [
        51
      ],
      "translation": [
        -0.0543088764,
        0.00331020355,
        -1.49011612e-8
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftForeArm",
      "children": [
        52
      ],
      "translation": [
        -0.208951667,
        -0.00568294525,
        -0.000754263252
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHand",
      "children": [
        53
      ],
      "translation": [
        -0.217726573,
        -0.000964283943,
        -0.00111226737
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftFingersBase",
      "children": [
        54,
        58,
        62,
        66,
        70
      ],
      "translation": [
        -0.003266871,
        0.000125050545,
        -0.00000651180744
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandIndex1",
      "children": [
        55
      ],
      "translation": [
        -0.049154,
        0.004017353,
        -0.01568903
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandIndex2",
      "children": [
        56
      ],
      "translation": [
        -0.0268839,
        -0.0017592907,
        0.000721149147
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandIndex3",
      "children": [
        57
      ],
      "translation": [
        -0.017280221,
        -0.00113499165,
        0.000253295526
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandIndex4",
      "translation": [
        -0.005766213,
        0.0002309084,
        -0.000004367903
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandMiddle1",
      "children": [
        59
      ],
      "translation": [
        -0.0497783571,
        0.00464177132,
        -0.001997199
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandMiddle2",
      "children": [
        60
      ],
      "translation": [
        -0.0308005214,
        -0.00180649757,
        8.828938e-7
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandMiddle3",
      "children": [
        61
      ],
      "translation": [
        -0.0187963843,
        -0.00111103058,
        -0.0000133812428
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandMiddle4",
      "translation": [
        -0.007554829,
        -0.00000500679,
        0.00007857755
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandPinky1",
      "children": [
        63
      ],
      "translation": [
        -0.0453163534,
        -0.0012960434,
        0.0222010911
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandPinky2",
      "children": [
        64
      ],
      "translation": [
        -0.0197808743,
        -0.00105917454,
        -0.00108123571
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandPinky3",
      "children": [
        65
      ],
      "translation": [
        -0.0134115815,
        -0.000741124153,
        -0.000545553863
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandPinky4",
      "translation": [
        -0.006527424,
        -0.000009655952,
        0.000004775822
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandRing1",
      "children": [
        67
      ],
      "translation": [
        -0.0494549423,
        0.0023214817,
        0.0110524818
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandRing2",
      "children": [
        68
      ],
      "translation": [
        -0.0237889886,
        -0.0012254715,
        -0.000999663
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandRing3",
      "children": [
        69
      ],
      "translation": [
        -0.016061008,
        -0.0008172989,
        -0.0005049184
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandRing4",
      "translation": [
        -0.007386565,
        -0.000348091125,
        0.000539053231
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandThumb1",
      "children": [
        71
      ],
      "translation": [
        -0.006750226,
        -0.008714795,
        -0.0154916365
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandThumb2",
      "children": [
        72
      ],
      "translation": [
        -0.0282387286,
        -0.007387519,
        -0.01403922
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandThumb3",
      "children": [
        73
      ],
      "translation": [
        -0.0196610689,
        -0.008030176,
        -0.0017064698
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "LeftHandThumb4",
      "translation": [
        -0.00429302454,
        -0.000784873962,
        -0.00044413656
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "Neck",
      "children": [
        75
      ],
      "translation": [
        3.33424381e-8,
        0.139848351,
        0.0142797269
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "Neck1",
      "children": [
        76
      ],
      "translation": [
        -9.09364e-9,
        0.03799796,
        0.000143527053
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "Head",
      "children": [
        77,
        78,
        79,
        80,
        81,
        89,
        97,
        99,
        101,
        103,
        104,
        108,
        109,
        113,
        114
      ],
      "translation": [
        -9.235208e-9,
        0.0388788,
        -0.00014353916
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "eye_L",
      "translation": [
        -0.0276441574,
        0.04640472,
        -0.0116034755
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "eye_light_L",
      "translation": [
        -0.0276441555,
        0.04640472,
        -0.0134033663
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "eye_light_R",
      "translation": [
        0.0276449937,
        0.04640472,
        -0.01340334
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "eye_R",
      "translation": [
        0.0276449919,
        0.04640472,
        -0.0116034495
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair1_L",
      "children": [
        82
      ],
      "translation": [
        -0.06572435,
        0.120691895,
        0.08068791
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair2_L",
      "children": [
        83
      ],
      "translation": [
        -0.006179832,
        -0.119360566,
        0.009650886
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair3_L",
      "children": [
        84
      ],
      "translation": [
        -0.0161171034,
        -0.09872854,
        0.01752311
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair4_L",
      "children": [
        85
      ],
      "translation": [
        -0.0353304222,
        -0.138894677,
        0.0251048952
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair5_L",
      "children": [
        86
      ],
      "translation": [
        -0.07046049,
        -0.117904425,
        0.048001796
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair6_L",
      "children": [
        87
      ],
      "translation": [
        -0.120002367,
        -0.138375878,
        0.0671004355
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair7_L",
      "children": [
        88
      ],
      "translation": [
        -0.0870507,
        -0.0946433544,
        0.04306592
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair8_L",
      "translation": [
        -0.04016853,
        -0.057079196,
        0.0142706931
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair1_R",
      "children": [
        90
      ],
      "translation": [
        0.06571994,
        0.120692134,
        0.08068797
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair2_R",
      "children": [
        91
      ],
      "translation": [
        0.00618789345,
        -0.119364977,
        0.00965409
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair3_R",
      "children": [
        92
      ],
      "translation": [
        0.0161163956,
        -0.09872699,
        0.0175223053
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair4_R",
      "children": [
        93
      ],
      "translation": [
        0.0353262275,
        -0.138896108,
        0.0251031071
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair5_R",
      "children": [
        94
      ],
      "translation": [
        0.07046034,
        -0.117904305,
        0.04800172
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair6_R",
      "children": [
        95
      ],
      "translation": [
        0.118575461,
        -0.136401892,
        0.06624928
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair7_R",
      "children": [
        96
      ],
      "translation": [
        0.08705064,
        -0.0946432352,
        0.04306598
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair8_R",
      "translation": [
        0.04016853,
        -0.0570790768,
        0.0142708123
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair_01_01",
      "children": [
        98
      ],
      "translation": [
        -0.00024026772,
        0.153529286,
        -0.0701631457
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair_01_02",
      "translation": [
        -0.004697134,
        -0.0465557575,
        -0.021267727
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair_02_01",
      "children": [
        100
      ],
      "translation": [
        -0.0341102779,
        0.154783368,
        -0.0651286542
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair_02_02",
      "translation": [
        -0.0175064914,
        -0.0475072861,
        -0.0132053047
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair_03_01",
      "children": [
        102
      ],
      "translation": [
        -0.0601437539,
        0.154783368,
        -0.0464953668
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "hair_03_02",
      "translation": [
        -0.0222170725,
        -0.04813528,
        0.000234309584
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "HeadEnd",
      "translation": [
        -1.7243579e-8,
        0.07203758,
        0.000143554062
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "mituami1",
      "children": [
        105
      ],
      "translation": [
        0.108901046,
        0.117511511,
        0.07002942
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "mituami2",
      "children": [
        106
      ],
      "translation": [
        0.0234252289,
        -0.07636464,
        0.00538140535
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "mituami3",
      "children": [
        107
      ],
      "translation": [
        0.0210470259,
        -0.06861162,
        0.00483505428
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "mituami4",
      "translation": [
        0.022419408,
        -0.07308555,
        0.005150363
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "mituami_F",
      "translation": [
        0.0383229926,
        0.144478321,
        0.01023296
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "mouth",
      "children": [
        110
      ],
      "translation": [
        2.86839921e-8,
        -0.0108946562,
        -0.05470737
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "tongue01",
      "children": [
        111
      ],
      "translation": [
        -7.77313147e-9,
        0.004326105,
        0.01413843
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "tongue02",
      "children": [
        112
      ],
      "translation": [
        6.94187463e-9,
        -0.00350046158,
        -0.0128080174
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "tongue03",
      "translation": [
        7.254961e-9,
        -0.00365817547,
        -0.0133856535
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "ribbon_L",
      "translation": [
        -0.009700051,
        0.201643348,
        0.005072986
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "ribbon_R",
      "translation": [
        0.00969995,
        0.201643229,
        0.00507301558
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightShoulder",
      "children": [
        116
      ],
      "translation": [
        0.0164300315,
        0.137162089,
        0.0226079449
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightArm",
      "children": [
        117
      ],
      "translation": [
        0.05432534,
        0.00302815437,
        -7.4505806e-8
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightForeArm",
      "children": [
        118
      ],
      "translation": [
        0.208922714,
        -0.006639719,
        -0.0009156652
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHand",
      "children": [
        119
      ],
      "translation": [
        0.2177248,
        -0.00103020668,
        -0.00134510174
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightFingersBase",
      "children": [
        120,
        124,
        128,
        132,
        136
      ],
      "translation": [
        0.00477924943,
        -0.0000578165054,
        -0.00009429455
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandIndex1",
      "children": [
        121
      ],
      "translation": [
        0.0476251841,
        0.004070282,
        -0.01568928
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandIndex2",
      "children": [
        122
      ],
      "translation": [
        0.0268845558,
        -0.00175893307,
        0.000699901953
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandIndex3",
      "children": [
        123
      ],
      "translation": [
        0.01728034,
        -0.00113666058,
        0.0002396889
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandIndex4",
      "translation": [
        0.0128848553,
        -0.00178790092,
        0.001090182
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandMiddle1",
      "children": [
        125
      ],
      "translation": [
        0.04826486,
        0.00479567051,
        -0.00200312585
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandMiddle2",
      "children": [
        126
      ],
      "translation": [
        0.0308001041,
        -0.00181388855,
        -0.0000223182142
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandMiddle3",
      "children": [
        127
      ],
      "translation": [
        0.0187960863,
        -0.001115799,
        -0.00002746284
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandMiddle4",
      "translation": [
        0.011297524,
        -0.0005426407,
        0.00136921555
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandPinky1",
      "children": [
        129
      ],
      "translation": [
        0.04382813,
        -0.000961661339,
        0.0222433321
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandPinky2",
      "children": [
        130
      ],
      "translation": [
        0.0197797418,
        -0.00107014179,
        -0.00109232217
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandPinky3",
      "children": [
        131
      ],
      "translation": [
        0.0134109259,
        -0.000747323036,
        -0.000552915037
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandPinky4",
      "translation": [
        0.00803405,
        -0.0005338192,
        0.00179671869
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandRing1",
      "children": [
        133
      ],
      "translation": [
        0.0479553938,
        0.00257217884,
        0.0110637173
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandRing2",
      "children": [
        134
      ],
      "translation": [
        0.0237876773,
        -0.00123846531,
        -0.00101491809
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandRing3",
      "children": [
        135
      ],
      "translation": [
        0.0160603523,
        -0.0008248091,
        -0.0005152896
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandRing4",
      "translation": [
        0.011380434,
        -0.000411510468,
        0.00163722038
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandThumb1",
      "children": [
        137
      ],
      "translation": [
        0.00521856546,
        -0.008648992,
        -0.0153509472
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandThumb2",
      "children": [
        138
      ],
      "translation": [
        0.02821511,
        -0.00748121738,
        -0.0140371677
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandThumb3",
      "children": [
        139
      ],
      "translation": [
        0.019664824,
        -0.008023024,
        -0.00169607252
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "RightHandThumb4",
      "translation": [
        0.00672757626,
        -0.00262367725,
        0.0009990782
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "tit_L",
      "translation": [
        -0.0319999866,
        0.06585765,
        0.00751654338
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "tit_R",
      "translation": [
        0.0320000164,
        0.06585753,
        0.007516627
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    },
    {
      "name": "secondary",
      "translation": [
        0,
        0,
        0
      ],
      "rotation": [
        0,
        0,
        0,
        1
      ],
      "scale": [
        1,
        1,
        1
      ],
      "extras": {}
    }
  ],
  "skins": [
    {
      "inverseBindMatrices": 200,
      "joints": [
        48,
        49,
        115,
        50,
        116,
        51,
        117,
        52,
        118,
        53,
        119,
        70,
        62,
        66,
        58,
        54,
        120,
        124,
        132,
        128,
        136,
        71,
        63,
        67,
        59,
        55,
        121,
        125,
        133,
        129,
        137,
        72,
        64,
        68,
        60,
        56,
        122,
        126,
        134,
        130,
        138,
        73,
        65,
        69,
        61,
        57,
        123,
        127,
        135,
        131,
        139,
        74,
        75,
        76,
        141,
        140,
        45,
        46,
        47,
        14,
        20,
        15
      ],
      "skeleton": 14
    },
    {
      "inverseBindMatrices": 201,
      "joints": [
        48,
        141,
        140,
        45,
        46,
        47,
        14,
        20,
        15,
        21,
        16,
        22,
        17,
        23,
        18,
        24,
        19
      ],
      "skeleton": 14
    },
    {
      "inverseBindMatrices": 202,
      "joints": [
        14,
        45,
        20,
        15,
        39,
        41,
        25,
        27,
        43,
        29,
        31,
        35,
        33,
        37,
        46,
        40,
        42,
        26,
        28,
        44,
        30,
        32,
        36,
        34,
        38,
        47,
        48,
        141,
        140
      ],
      "skeleton": 14
    },
    {
      "inverseBindMatrices": 203,
      "joints": [
        14,
        45,
        20,
        15,
        39,
        41,
        25,
        27,
        43,
        29,
        31,
        35,
        33,
        37,
        40,
        42,
        26,
        28,
        44,
        30,
        32,
        36,
        34,
        38
      ],
      "skeleton": 14
    },
    {
      "inverseBindMatrices": 204,
      "joints": [
        14,
        45,
        39,
        41,
        25,
        27,
        43,
        29,
        31,
        35,
        33,
        37,
        40,
        42,
        26,
        28,
        44,
        30,
        32,
        36,
        34,
        38
      ],
      "skeleton": 14
    },
    {
      "inverseBindMatrices": 205,
      "joints": [
        14,
        39,
        41,
        25,
        27,
        43,
        29,
        31,
        35,
        33,
        37,
        40,
        42,
        26,
        28,
        44,
        30,
        32,
        36,
        34,
        38
      ],
      "skeleton": 14
    },
    {
      "inverseBindMatrices": 206,
      "joints": [
        76,
        99,
        77,
        78,
        80,
        79,
        103,
        102,
        112
      ],
      "skeleton": 76
    },
    {
      "inverseBindMatrices": 207,
      "joints": [
        74,
        75,
        76,
        108,
        97,
        99,
        101,
        114,
        77,
        78,
        80,
        79,
        109,
        81,
        103,
        98,
        100,
        102,
        110,
        82,
        111,
        112
      ],
      "skeleton": 74
    },
    {
      "inverseBindMatrices": 208,
      "joints": [
        76,
        108,
        97,
        99,
        101,
        113,
        114,
        77,
        78,
        80,
        79,
        104,
        81,
        89,
        103,
        98,
        100,
        102,
        105,
        82,
        90,
        106,
        83,
        91,
        112,
        107,
        84,
        92,
        85,
        93,
        86,
        94,
        87,
        95,
        88,
        96
      ],
      "skeleton": 76
    },
    {
      "inverseBindMatrices": 209,
      "joints": [
        75,
        76,
        77,
        80,
        79,
        109,
        110,
        111,
        112,
        74,
        48
      ],
      "skeleton": 48
    },
    {
      "inverseBindMatrices": 210,
      "joints": [
        76,
        108,
        97,
        99,
        77,
        78,
        80,
        79,
        103,
        98,
        100,
        102,
        112
      ],
      "skeleton": 76
    },
    {
      "inverseBindMatrices": 211,
      "joints": [
        76,
        77,
        78,
        80,
        79,
        103
      ],
      "skeleton": 76
    }
  ],
  "scene": 0,
  "scenes": [
    {
      "nodes": [
        0,
        13,
        142
      ]
    }
  ],
  "extensionsUsed": [
    "KHR_materials_unlit",
    "VRM"
  ],
  "extensions": {
    "VRM": {
      "exporterVersion": "UniVRM-0.51.0",
      "specVersion": "0.0",
      "meta": {
        "title": "Alicia Solid",
        "version": "1.10",
        "author": "© DWANGO Co., Ltd.",
        "contactInformation": "https://3d.nicovideo.jp/alicia/",
        "reference": "",
        "texture": 7,
        "allowedUserName": "Everyone",
        "violentUssageName": "Disallow",
        "sexualUssageName": "Disallow",
        "commercialUssageName": "Allow",
        "otherPermissionUrl": "https://3d.nicovideo.jp/alicia/rule.html",
        "licenseName": "Other",
        "otherLicenseUrl": "https://3d.nicovideo.jp/alicia/rule.html"
      },
      "humanoid": {
        "humanBones": [
          {
            "bone": "hips",
            "node": 14,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftUpperLeg",
            "node": 15,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightUpperLeg",
            "node": 20,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftLowerLeg",
            "node": 16,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightLowerLeg",
            "node": 21,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftFoot",
            "node": 17,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightFoot",
            "node": 22,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "spine",
            "node": 45,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "chest",
            "node": 46,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "neck",
            "node": 74,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "head",
            "node": 76,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftShoulder",
            "node": 49,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightShoulder",
            "node": 115,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftUpperArm",
            "node": 50,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightUpperArm",
            "node": 116,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftLowerArm",
            "node": 51,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightLowerArm",
            "node": 117,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftHand",
            "node": 52,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightHand",
            "node": 118,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftToes",
            "node": 18,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightToes",
            "node": 23,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftEye",
            "node": 77,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightEye",
            "node": 80,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "jaw",
            "node": 109,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftThumbProximal",
            "node": 70,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftThumbIntermediate",
            "node": 71,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftThumbDistal",
            "node": 72,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftIndexProximal",
            "node": 54,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftIndexIntermediate",
            "node": 55,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftIndexDistal",
            "node": 56,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftMiddleProximal",
            "node": 58,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftMiddleIntermediate",
            "node": 59,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftMiddleDistal",
            "node": 60,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftRingProximal",
            "node": 66,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftRingIntermediate",
            "node": 67,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftRingDistal",
            "node": 68,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftLittleProximal",
            "node": 62,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftLittleIntermediate",
            "node": 63,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "leftLittleDistal",
            "node": 64,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightThumbProximal",
            "node": 136,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightThumbIntermediate",
            "node": 137,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightThumbDistal",
            "node": 138,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightIndexProximal",
            "node": 120,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightIndexIntermediate",
            "node": 121,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightIndexDistal",
            "node": 122,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightMiddleProximal",
            "node": 124,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightMiddleIntermediate",
            "node": 125,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightMiddleDistal",
            "node": 126,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightRingProximal",
            "node": 132,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightRingIntermediate",
            "node": 133,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightRingDistal",
            "node": 134,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightLittleProximal",
            "node": 128,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightLittleIntermediate",
            "node": 129,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "rightLittleDistal",
            "node": 130,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          },
          {
            "bone": "upperChest",
            "node": 48,
            "useDefaultValues": true,
            "min": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "max": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "center": {
              "x": 0,
              "y": 0,
              "z": 0
            },
            "axisLength": 0
          }
        ],
        "armStretch": 0.05,
        "legStretch": 0.05,
        "upperArmTwist": 0.5,
        "lowerArmTwist": 0.5,
        "upperLegTwist": 0.5,
        "lowerLegTwist": 0.5,
        "feetSpacing": 0,
        "hasTranslationDoF": false
      },
      "firstPerson": {
        "firstPersonBone": 76,
        "firstPersonBoneOffset": {
          "x": 0,
          "y": 0.0599999428,
          "z": 0
        },
        "meshAnnotations": [
          {
            "mesh": 0,
            "firstPersonFlag": "Auto"
          },
          {
            "mesh": 1,
            "firstPersonFlag": "Auto"
          },
          {
            "mesh": 2,
            "firstPersonFlag": "Auto"
          },
          {
            "mesh": 3,
            "firstPersonFlag": "Auto"
          },
          {
            "mesh": 4,
            "firstPersonFlag": "Auto"
          },
          {
            "mesh": 5,
            "firstPersonFlag": "Auto"
          },
          {
            "mesh": 6,
            "firstPersonFlag": "Auto"
          },
          {
            "mesh": 7,
            "firstPersonFlag": "Auto"
          },
          {
            "mesh": 8,
            "firstPersonFlag": "Auto"
          },
          {
            "mesh": 9,
            "firstPersonFlag": "Auto"
          },
          {
            "mesh": 10,
            "firstPersonFlag": "Auto"
          },
          {
            "mesh": 11,
            "firstPersonFlag": "Auto"
          }
        ],
        "lookAtTypeName": "Bone",
        "lookAtHorizontalInner": {
          "curve": [
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0
          ],
          "xRange": 20,
          "yRange": 5
        },
        "lookAtHorizontalOuter": {
          "curve": [
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0
          ],
          "xRange": 20,
          "yRange": 5
        },
        "lookAtVerticalDown": {
          "curve": [
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0
          ],
          "xRange": 20,
          "yRange": 5
        },
        "lookAtVerticalUp": {
          "curve": [
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0
          ],
          "xRange": 20,
          "yRange": 5
        }
      },
      "blendShapeMaster": {
        "blendShapeGroups": [
          {
            "name": "Neutral",
            "presetName": "neutral",
            "binds": [],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "A",
            "presetName": "a",
            "binds": [
              {
                "mesh": 7,
                "index": 0,
                "weight": 100
              }
            ],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "I",
            "presetName": "i",
            "binds": [
              {
                "mesh": 7,
                "index": 1,
                "weight": 100
              }
            ],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "U",
            "presetName": "u",
            "binds": [
              {
                "mesh": 7,
                "index": 2,
                "weight": 100
              }
            ],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "E",
            "presetName": "e",
            "binds": [
              {
                "mesh": 7,
                "index": 3,
                "weight": 100
              }
            ],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "O",
            "presetName": "o",
            "binds": [
              {
                "mesh": 7,
                "index": 4,
                "weight": 100
              }
            ],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "Blink",
            "presetName": "blink",
            "binds": [
              {
                "mesh": 7,
                "index": 24,
                "weight": 100
              }
            ],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "Joy",
            "presetName": "joy",
            "binds": [
              {
                "mesh": 7,
                "index": 25,
                "weight": 100
              },
              {
                "mesh": 7,
                "index": 38,
                "weight": 100
              }
            ],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "Angry",
            "presetName": "angry",
            "binds": [
              {
                "mesh": 7,
                "index": 34,
                "weight": 100
              },
              {
                "mesh": 7,
                "index": 39,
                "weight": 100
              }
            ],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "Sorrow",
            "presetName": "sorrow",
            "binds": [
              {
                "mesh": 7,
                "index": 30,
                "weight": 100
              },
              {
                "mesh": 7,
                "index": 37,
                "weight": 100
              }
            ],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "Fun",
            "presetName": "fun",
            "binds": [
              {
                "mesh": 7,
                "index": 33,
                "weight": 100
              },
              {
                "mesh": 7,
                "index": 38,
                "weight": 100
              },
              {
                "mesh": 10,
                "index": 0,
                "weight": 100
              }
            ],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "LookUp",
            "presetName": "lookup",
            "binds": [],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "LookDown",
            "presetName": "lookdown",
            "binds": [],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "LookLeft",
            "presetName": "lookleft",
            "binds": [],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "LookRight",
            "presetName": "lookright",
            "binds": [],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "Blink_L",
            "presetName": "blink_l",
            "binds": [
              {
                "mesh": 7,
                "index": 28,
                "weight": 100
              }
            ],
            "materialValues": [],
            "isBinary": false
          },
          {
            "name": "Blink_R",
            "presetName": "blink_r",
            "binds": [
              {
                "mesh": 7,
                "index": 29,
                "weight": 100
              }
            ],
            "materialValues": [],
            "isBinary": false
          }
        ]
      },
      "secondaryAnimation": {
        "boneGroups": [
          {
            "comment": "",
            "stiffiness": 2,
            "gravityPower": 0,
            "gravityDir": {
              "x": 0,
              "y": -1,
              "z": 0
            },
            "dragForce": 0.7,
            "center": -1,
            "hitRadius": 0.02,
            "bones": [
              97,
              99,
              101,
              113,
              114
            ],
            "colliderGroups": [
              3,
              4,
              5
            ]
          },
          {
            "comment": "",
            "stiffiness": 1.6,
            "gravityPower": 0,
            "gravityDir": {
              "x": 0,
              "y": -1,
              "z": 0
            },
            "dragForce": 0.5,
            "center": -1,
            "hitRadius": 0.02,
            "bones": [
              81,
              89,
              104
            ],
            "colliderGroups": [
              3,
              4,
              5
            ]
          },
          {
            "comment": "",
            "stiffiness": 1,
            "gravityPower": 0.05,
            "gravityDir": {
              "x": 0,
              "y": -1,
              "z": 0
            },
            "dragForce": 0.8,
            "center": -1,
            "hitRadius": 0.05,
            "bones": [
              25,
              27,
              29,
              31,
              33,
              35,
              37,
              39,
              41,
              43
            ],
            "colliderGroups": [
              0,
              1,
              2,
              3,
              5
            ]
          }
        ],
        "colliderGroups": [
          {
            "node": 14,
            "colliders": [
              {
                "offset": {
                  "x": 0.025884293,
                  "y": -0.120000005,
                  "z": 0
                },
                "radius": 0.05
              },
              {
                "offset": {
                  "x": -0.02588429,
                  "y": -0.120000005,
                  "z": 0
                },
                "radius": 0.05
              },
              {
                "offset": {
                  "x": 0,
                  "y": -0.0220816135,
                  "z": 0
                },
                "radius": 0.08
              }
            ]
          },
          {
            "node": 15,
            "colliders": [
              {
                "offset": {
                  "x": -0.0119830407,
                  "y": -0.04460001,
                  "z": 0.00390054286
                },
                "radius": 0.05
              },
              {
                "offset": {
                  "x": -0.0119830407,
                  "y": -0.118150711,
                  "z": 0.009765223
                },
                "radius": 0.05
              },
              {
                "offset": {
                  "x": -0.0119830407,
                  "y": -0.204597,
                  "z": 0.009763375
                },
                "radius": 0.06
              }
            ]
          },
          {
            "node": 20,
            "colliders": [
              {
                "offset": {
                  "x": 0.01198304,
                  "y": -0.04460001,
                  "z": 0.00390054286
                },
                "radius": 0.05
              },
              {
                "offset": {
                  "x": 0.01198304,
                  "y": -0.118150711,
                  "z": 0.009765223
                },
                "radius": 0.05
              },
              {
                "offset": {
                  "x": 0.01198304,
                  "y": -0.204597,
                  "z": 0.009763375
                },
                "radius": 0.06
              }
            ]
          },
          {
            "node": 52,
            "colliders": [
              {
                "offset": {
                  "x": -0.0359970331,
                  "y": -0.0188314915,
                  "z": 0.00566166639
                },
                "radius": 0.04
              },
              {
                "offset": {
                  "x": -0.099316895,
                  "y": -0.024091363,
                  "z": -0.0013499856
                },
                "radius": 0.035
              }
            ]
          },
          {
            "node": 76,
            "colliders": [
              {
                "offset": {
                  "x": 0,
                  "y": 0.07463479,
                  "z": -0.01170056
                },
                "radius": 0.084
              }
            ]
          },
          {
            "node": 118,
            "colliders": [
              {
                "offset": {
                  "x": 0.03599703,
                  "y": -0.0188314915,
                  "z": 0.00566166639
                },
                "radius": 0.04
              },
              {
                "offset": {
                  "x": 0.0993169,
                  "y": -0.024091363,
                  "z": -0.0013499856
                },
                "radius": 0.035
              }
            ]
          }
        ]
      },
      "materialProperties": [
        {
          "name": "Alicia_body",
          "shader": "VRM/MToon",
          "renderQueue": 2000,
          "floatProperties": {
            "_Cutoff": 0.5,
            "_BumpScale": 1,
            "_ReceiveShadowRate": 1,
            "_ShadingGradeRate": 1,
            "_ShadeShift": 0,
            "_ShadeToony": 0.9,
            "_LightColorAttenuation": 0,
            "_IndirectLightIntensity": 0.1,
            "_OutlineWidth": 0.05,
            "_OutlineScaledMaxDistance": 1,
            "_OutlineLightingMix": 1,
            "_DebugMode": 0,
            "_BlendMode": 0,
            "_OutlineWidthMode": 1,
            "_OutlineColorMode": 1,
            "_CullMode": 2,
            "_OutlineCullMode": 1,
            "_SrcBlend": 1,
            "_DstBlend": 0,
            "_ZWrite": 1
          },
          "vectorProperties": {
            "_Color": [
              1,
              1,
              1,
              1
            ],
            "_ShadeColor": [
              1,
              0.8666667,
              0.840000033,
              1
            ],
            "_MainTex": [
              0,
              0,
              1,
              1
            ],
            "_ShadeTexture": [
              0,
              0,
              1,
              1
            ],
            "_BumpMap": [
              0,
              0,
              1,
              1
            ],
            "_ReceiveShadowTexture": [
              0,
              0,
              1,
              1
            ],
            "_ShadingGradeTexture": [
              0,
              0,
              1,
              1
            ],
            "_SphereAdd": [
              0,
              0,
              1,
              1
            ],
            "_EmissionColor": [
              0,
              0,
              0,
              1
            ],
            "_EmissionMap": [
              0,
              0,
              1,
              1
            ],
            "_OutlineWidthTexture": [
              0,
              0,
              1,
              1
            ],
            "_OutlineColor": [
              0.671,
              0.55702585,
              0.53478694,
              1
            ]
          },
          "textureProperties": {
            "_MainTex": 0,
            "_ShadeTexture": 0,
            "_SphereAdd": 1
          },
          "keywordMap": {
            "MTOON_OUTLINE_COLORED": true,
            "MTOON_OUTLINE_COLOR_MIXED": true,
            "MTOON_OUTLINE_WIDTH_WORLD": true
          },
          "tagMap": {
            "RenderType": "Opaque"
          }
        },
        {
          "name": "Alicia_body_wear",
          "shader": "VRM/MToon",
          "renderQueue": 2000,
          "floatProperties": {
            "_Cutoff": 0.5,
            "_BumpScale": 1,
            "_ReceiveShadowRate": 1,
            "_ShadingGradeRate": 1,
            "_ShadeShift": 0,
            "_ShadeToony": 0.9,
            "_LightColorAttenuation": 0,
            "_IndirectLightIntensity": 0.1,
            "_OutlineWidth": 0.05,
            "_OutlineScaledMaxDistance": 1,
            "_OutlineLightingMix": 1,
            "_DebugMode": 0,
            "_BlendMode": 0,
            "_OutlineWidthMode": 1,
            "_OutlineColorMode": 1,
            "_CullMode": 2,
            "_OutlineCullMode": 1,
            "_SrcBlend": 1,
            "_DstBlend": 0,
            "_ZWrite": 1
          },
          "vectorProperties": {
            "_Color": [
              1,
              1,
              1,
              1
            ],
            "_ShadeColor": [
              0.5686274,
              0.776470661,
              0.92549026,
              1
            ],
            "_MainTex": [
              0,
              0,
              1,
              1
            ],
            "_ShadeTexture": [
              0,
              0,
              1,
              1
            ],
            "_BumpMap": [
              0,
              0,
              1,
              1
            ],
            "_ReceiveShadowTexture": [
              0,
              0,
              1,
              1
            ],
            "_ShadingGradeTexture": [
              0,
              0,
              1,
              1
            ],
            "_SphereAdd": [
              0,
              0,
              1,
              1
            ],
            "_EmissionColor": [
              0,
              0,
              0,
              1
            ],
            "_EmissionMap": [
              0,
              0,
              1,
              1
            ],
            "_OutlineWidthTexture": [
              0,
              0,
              1,
              1
            ],
            "_OutlineColor": [
              0.449124157,
              0.494896948,
              0.522058845,
              1
            ]
          },
          "textureProperties": {
            "_MainTex": 0,
            "_ShadeTexture": 0,
            "_SphereAdd": 1
          },
          "keywordMap": {
            "MTOON_OUTLINE_COLORED": true,
            "MTOON_OUTLINE_COLOR_MIXED": true,
            "MTOON_OUTLINE_WIDTH_WORLD": true
          },
          "tagMap": {
            "RenderType": "Opaque"
          }
        },
        {
          "name": "Alicia_wear",
          "shader": "VRM/MToon",
          "renderQueue": 2000,
          "floatProperties": {
            "_Cutoff": 0.5,
            "_BumpScale": 1,
            "_ReceiveShadowRate": 1,
            "_ShadingGradeRate": 1,
            "_ShadeShift": 0,
            "_ShadeToony": 0.9,
            "_LightColorAttenuation": 0,
            "_IndirectLightIntensity": 0.1,
            "_OutlineWidth": 0.05,
            "_OutlineScaledMaxDistance": 1,
            "_OutlineLightingMix": 1,
            "_DebugMode": 0,
            "_BlendMode": 0,
            "_OutlineWidthMode": 1,
            "_OutlineColorMode": 1,
            "_CullMode": 2,
            "_OutlineCullMode": 1,
            "_SrcBlend": 1,
            "_DstBlend": 0,
            "_ZWrite": 1
          },
          "vectorProperties": {
            "_Color": [
              1,
              1,
              1,
              1
            ],
            "_ShadeColor": [
              0.5686274,
              0.776470661,
              0.92549026,
              1
            ],
            "_MainTex": [
              0,
              0,
              1,
              1
            ],
            "_ShadeTexture": [
              0,
              0,
              1,
              1
            ],
            "_BumpMap": [
              0,
              0,
              1,
              1
            ],
            "_ReceiveShadowTexture": [
              0,
              0,
              1,
              1
            ],
            "_ShadingGradeTexture": [
              0,
              0,
              1,
              1
            ],
            "_SphereAdd": [
              0,
              0,
              1,
              1
            ],
            "_EmissionColor": [
              0,
              0,
              0,
              1
            ],
            "_EmissionMap": [
              0,
              0,
              1,
              1
            ],
            "_OutlineWidthTexture": [
              0,
              0,
              1,
              1
            ],
            "_OutlineColor": [
              0.449124157,
              0.494896948,
              0.522058845,
              1
            ]
          },
          "textureProperties": {
            "_MainTex": 2,
            "_ShadeTexture": 2,
            "_SphereAdd": 1
          },
          "keywordMap": {
            "MTOON_OUTLINE_COLORED": true,
            "MTOON_OUTLINE_COLOR_MIXED": true,
            "MTOON_OUTLINE_WIDTH_WORLD": true
          },
          "tagMap": {
            "RenderType": "Opaque"
          }
        },
        {
          "name": "Alicia_eye",
          "shader": "VRM/MToon",
          "renderQueue": 2000,
          "floatProperties": {
            "_Cutoff": 0.5,
            "_BumpScale": 1,
            "_ReceiveShadowRate": 1,
            "_ShadingGradeRate": 1,
            "_ShadeShift": -0.5,
            "_ShadeToony": 0.9,
            "_LightColorAttenuation": 0,
            "_IndirectLightIntensity": 0.1,
            "_OutlineWidth": 0.601,
            "_OutlineScaledMaxDistance": 1,
            "_OutlineLightingMix": 1,
            "_DebugMode": 0,
            "_BlendMode": 0,
            "_OutlineWidthMode": 0,
            "_OutlineColorMode": 0,
            "_CullMode": 2,
            "_OutlineCullMode": 1,
            "_SrcBlend": 1,
            "_DstBlend": 0,
            "_ZWrite": 1
          },
          "vectorProperties": {
            "_Color": [
              1,
              1,
              1,
              1
            ],
            "_ShadeColor": [
              0.881,
              0.949796855,
              1,
              1
            ],
            "_MainTex": [
              0,
              0,
              1,
              1
            ],
            "_ShadeTexture": [
              0,
              0,
              1,
              1
            ],
            "_BumpMap": [
              0,
              0,
              1,
              1
            ],
            "_ReceiveShadowTexture": [
              0,
              0,
              1,
              1
            ],
            "_ShadingGradeTexture": [
              0,
              0,
              1,
              1
            ],
            "_SphereAdd": [
              0,
              0,
              1,
              1
            ],
            "_EmissionColor": [
              0,
              0,
              0,
              1
            ],
            "_EmissionMap": [
              0,
              0,
              1,
              1
            ],
            "_OutlineWidthTexture": [
              0,
              0,
              1,
              1
            ],
            "_OutlineColor": [
              0,
              0,
              0,
              1
            ]
          },
          "textureProperties": {
            "_MainTex": 3,
            "_ShadeTexture": 3
          },
          "keywordMap": {},
          "tagMap": {
            "RenderType": "Opaque"
          }
        },
        {
          "name": "Alicia_face",
          "shader": "VRM/MToon",
          "renderQueue": 2000,
          "floatProperties": {
            "_Cutoff": 0.5,
            "_BumpScale": 1,
            "_ReceiveShadowRate": 1,
            "_ShadingGradeRate": 1,
            "_ShadeShift": -0.5,
            "_ShadeToony": 0.9,
            "_LightColorAttenuation": 0,
            "_IndirectLightIntensity": 0.1,
            "_OutlineWidth": 0.05,
            "_OutlineScaledMaxDistance": 1,
            "_OutlineLightingMix": 1,
            "_DebugMode": 0,
            "_BlendMode": 0,
            "_OutlineWidthMode": 1,
            "_OutlineColorMode": 1,
            "_CullMode": 2,
            "_OutlineCullMode": 1,
            "_SrcBlend": 1,
            "_DstBlend": 0,
            "_ZWrite": 1
          },
          "vectorProperties": {
            "_Color": [
              1,
              1,
              1,
              1
            ],
            "_ShadeColor": [
              1,
              0.8666667,
              0.840000033,
              1
            ],
            "_MainTex": [
              0,
              0,
              1,
              1
            ],
            "_ShadeTexture": [
              0,
              0,
              1,
              1
            ],
            "_BumpMap": [
              0,
              0,
              1,
              1
            ],
            "_ReceiveShadowTexture": [
              0,
              0,
              1,
              1
            ],
            "_ShadingGradeTexture": [
              0,
              0,
              1,
              1
            ],
            "_SphereAdd": [
              0,
              0,
              1,
              1
            ],
            "_EmissionColor": [
              0,
              0,
              0,
              1
            ],
            "_EmissionMap": [
              0,
              0,
              1,
              1
            ],
            "_OutlineWidthTexture": [
              0,
              0,
              1,
              1
            ],
            "_OutlineColor": [
              0.671,
              0.55702585,
              0.53478694,
              1
            ]
          },
          "textureProperties": {
            "_MainTex": 4,
            "_ShadeTexture": 4
          },
          "keywordMap": {
            "MTOON_OUTLINE_COLORED": true,
            "MTOON_OUTLINE_COLOR_MIXED": true,
            "MTOON_OUTLINE_WIDTH_WORLD": true
          },
          "tagMap": {
            "RenderType": "Opaque"
          }
        },
        {
          "name": "Alicia_eye_white",
          "shader": "VRM/MToon",
          "renderQueue": 2000,
          "floatProperties": {
            "_Cutoff": 0.5,
            "_BumpScale": 1,
            "_ReceiveShadowRate": 1,
            "_ShadingGradeRate": 1,
            "_ShadeShift": -0.5,
            "_ShadeToony": 0.9,
            "_LightColorAttenuation": 0,
            "_IndirectLightIntensity": 0.1,
            "_OutlineWidth": 0.601,
            "_OutlineScaledMaxDistance": 1,
            "_OutlineLightingMix": 1,
            "_DebugMode": 0,
            "_BlendMode": 0,
            "_OutlineWidthMode": 0,
            "_OutlineColorMode": 0,
            "_CullMode": 2,
            "_OutlineCullMode": 1,
            "_SrcBlend": 1,
            "_DstBlend": 0,
            "_ZWrite": 1
          },
          "vectorProperties": {
            "_Color": [
              1,
              1,
              1,
              1
            ],
            "_ShadeColor": [
              0.881,
              0.949796855,
              1,
              1
            ],
            "_MainTex": [
              0,
              0,
              1,
              1
            ],
            "_ShadeTexture": [
              0,
              0,
              1,
              1
            ],
            "_BumpMap": [
              0,
              0,
              1,
              1
            ],
            "_ReceiveShadowTexture": [
              0,
              0,
              1,
              1
            ],
            "_ShadingGradeTexture": [
              0,
              0,
              1,
              1
            ],
            "_SphereAdd": [
              0,
              0,
              1,
              1
            ],
            "_EmissionColor": [
              0,
              0,
              0,
              1
            ],
            "_EmissionMap": [
              0,
              0,
              1,
              1
            ],
            "_OutlineWidthTexture": [
              0,
              0,
              1,
              1
            ],
            "_OutlineColor": [
              0,
              0,
              0,
              1
            ]
          },
          "textureProperties": {
            "_MainTex": 4,
            "_ShadeTexture": 4
          },
          "keywordMap": {},
          "tagMap": {
            "RenderType": "Opaque"
          }
        },
        {
          "name": "Alicia_face_mastuge",
          "shader": "VRM/MToon",
          "renderQueue": 2501,
          "floatProperties": {
            "_Cutoff": 0.5,
            "_BumpScale": 1,
            "_ReceiveShadowRate": 1,
            "_ShadingGradeRate": 1,
            "_ShadeShift": -0.5,
            "_ShadeToony": 0.9,
            "_LightColorAttenuation": 0,
            "_IndirectLightIntensity": 0.1,
            "_OutlineWidth": 0.601,
            "_OutlineScaledMaxDistance": 1,
            "_OutlineLightingMix": 1,
            "_DebugMode": 0,
            "_BlendMode": 3,
            "_OutlineWidthMode": 0,
            "_OutlineColorMode": 0,
            "_CullMode": 2,
            "_OutlineCullMode": 1,
            "_SrcBlend": 5,
            "_DstBlend": 10,
            "_ZWrite": 1
          },
          "vectorProperties": {
            "_Color": [
              1,
              1,
              1,
              1
            ],
            "_ShadeColor": [
              1,
              0.8666667,
              0.840000033,
              1
            ],
            "_MainTex": [
              0,
              0,
              1,
              1
            ],
            "_ShadeTexture": [
              0,
              0,
              1,
              1
            ],
            "_BumpMap": [
              0,
              0,
              1,
              1
            ],
            "_ReceiveShadowTexture": [
              0,
              0,
              1,
              1
            ],
            "_ShadingGradeTexture": [
              0,
              0,
              1,
              1
            ],
            "_SphereAdd": [
              0,
              0,
              1,
              1
            ],
            "_EmissionColor": [
              0,
              0,
              0,
              1
            ],
            "_EmissionMap": [
              0,
              0,
              1,
              1
            ],
            "_OutlineWidthTexture": [
              0,
              0,
              1,
              1
            ],
            "_OutlineColor": [
              0,
              0,
              0,
              1
            ]
          },
          "textureProperties": {
            "_MainTex": 4,
            "_ShadeTexture": 4
          },
          "keywordMap": {
            "_ALPHABLEND_ON": true
          },
          "tagMap": {
            "RenderType": "Transparent"
          }
        },
        {
          "name": "Alicia_hair",
          "shader": "VRM/MToon",
          "renderQueue": 2000,
          "floatProperties": {
            "_Cutoff": 0.5,
            "_BumpScale": 1,
            "_ReceiveShadowRate": 1,
            "_ShadingGradeRate": 1,
            "_ShadeShift": 0,
            "_ShadeToony": 0,
            "_LightColorAttenuation": 0,
            "_IndirectLightIntensity": 0.1,
            "_OutlineWidth": 0.05,
            "_OutlineScaledMaxDistance": 1,
            "_OutlineLightingMix": 1,
            "_DebugMode": 0,
            "_BlendMode": 0,
            "_OutlineWidthMode": 1,
            "_OutlineColorMode": 1,
            "_CullMode": 2,
            "_OutlineCullMode": 1,
            "_SrcBlend": 1,
            "_DstBlend": 0,
            "_ZWrite": 1
          },
          "vectorProperties": {
            "_Color": [
              1,
              1,
              1,
              1
            ],
            "_ShadeColor": [
              1,
              0.779,
              0.7619999,
              1
            ],
            "_MainTex": [
              0,
              0,
              1,
              1
            ],
            "_ShadeTexture": [
              0,
              0,
              1,
              1
            ],
            "_BumpMap": [
              0,
              0,
              1,
              1
            ],
            "_ReceiveShadowTexture": [
              0,
              0,
              1,
              1
            ],
            "_ShadingGradeTexture": [
              0,
              0,
              1,
              1
            ],
            "_SphereAdd": [
              0,
              0,
              1,
              1
            ],
            "_EmissionColor": [
              0,
              0,
              0,
              1
            ],
            "_EmissionMap": [
              0,
              0,
              1,
              1
            ],
            "_OutlineWidthTexture": [
              0,
              0,
              1,
              1
            ],
            "_OutlineColor": [
              0.8039216,
              0.7825373,
              0.742823541,
              1
            ]
          },
          "textureProperties": {
            "_MainTex": 5,
            "_ShadeTexture": 5,
            "_SphereAdd": 1
          },
          "keywordMap": {
            "MTOON_OUTLINE_COLORED": true,
            "MTOON_OUTLINE_COLOR_MIXED": true,
            "MTOON_OUTLINE_WIDTH_WORLD": true
          },
          "tagMap": {
            "RenderType": "Opaque"
          }
        },
        {
          "name": "Alicia_hair_trans_zwrite",
          "shader": "VRM/MToon",
          "renderQueue": 2550,
          "floatProperties": {
            "_Cutoff": 0.5,
            "_BumpScale": 1,
            "_ReceiveShadowRate": 1,
            "_ShadingGradeRate": 1,
            "_ShadeShift": 0,
            "_ShadeToony": 0,
            "_LightColorAttenuation": 0,
            "_IndirectLightIntensity": 0.1,
            "_OutlineWidth": 0.05,
            "_OutlineScaledMaxDistance": 1,
            "_OutlineLightingMix": 1,
            "_DebugMode": 0,
            "_BlendMode": 3,
            "_OutlineWidthMode": 1,
            "_OutlineColorMode": 1,
            "_CullMode": 2,
            "_OutlineCullMode": 1,
            "_SrcBlend": 5,
            "_DstBlend": 10,
            "_ZWrite": 1
          },
          "vectorProperties": {
            "_Color": [
              1,
              1,
              1,
              1
            ],
            "_ShadeColor": [
              1,
              0.779,
              0.7619999,
              1
            ],
            "_MainTex": [
              0,
              0,
              1,
              1
            ],
            "_ShadeTexture": [
              0,
              0,
              1,
              1
            ],
            "_BumpMap": [
              0,
              0,
              1,
              1
            ],
            "_ReceiveShadowTexture": [
              0,
              0,
              1,
              1
            ],
            "_ShadingGradeTexture": [
              0,
              0,
              1,
              1
            ],
            "_SphereAdd": [
              0,
              0,
              1,
              1
            ],
            "_EmissionColor": [
              0,
              0,
              0,
              1
            ],
            "_EmissionMap": [
              0,
              0,
              1,
              1
            ],
            "_OutlineWidthTexture": [
              0,
              0,
              1,
              1
            ],
            "_OutlineColor": [
              0.8039216,
              0.7825373,
              0.742823541,
              1
            ]
          },
          "textureProperties": {
            "_MainTex": 5,
            "_ShadeTexture": 5,
            "_SphereAdd": 1
          },
          "keywordMap": {
            "MTOON_OUTLINE_COLOR_MIXED": true,
            "MTOON_OUTLINE_WIDTH_WORLD": true,
            "_ALPHABLEND_ON": true
          },
          "tagMap": {
            "RenderType": "Transparent"
          }
        },
        {
          "name": "Alicia_hair_wear",
          "shader": "VRM/MToon",
          "renderQueue": 2000,
          "floatProperties": {
            "_Cutoff": 0.5,
            "_BumpScale": 1,
            "_ReceiveShadowRate": 1,
            "_ShadingGradeRate": 1,
            "_ShadeShift": 0,
            "_ShadeToony": 0.9,
            "_LightColorAttenuation": 0,
            "_IndirectLightIntensity": 0.1,
            "_OutlineWidth": 0.05,
            "_OutlineScaledMaxDistance": 1,
            "_OutlineLightingMix": 1,
            "_DebugMode": 0,
            "_BlendMode": 0,
            "_OutlineWidthMode": 1,
            "_OutlineColorMode": 1,
            "_CullMode": 2,
            "_OutlineCullMode": 1,
            "_SrcBlend": 1,
            "_DstBlend": 0,
            "_ZWrite": 1
          },
          "vectorProperties": {
            "_Color": [
              1,
              1,
              1,
              1
            ],
            "_ShadeColor": [
              0.5686274,
              0.776470661,
              0.92549026,
              1
            ],
            "_MainTex": [
              0,
              0,
              1,
              1
            ],
            "_ShadeTexture": [
              0,
              0,
              1,
              1
            ],
            "_BumpMap": [
              0,
              0,
              1,
              1
            ],
            "_ReceiveShadowTexture": [
              0,
              0,
              1,
              1
            ],
            "_ShadingGradeTexture": [
              0,
              0,
              1,
              1
            ],
            "_SphereAdd": [
              0,
              0,
              1,
              1
            ],
            "_EmissionColor": [
              0,
              0,
              0,
              1
            ],
            "_EmissionMap": [
              0,
              0,
              1,
              1
            ],
            "_OutlineWidthTexture": [
              0,
              0,
              1,
              1
            ],
            "_OutlineColor": [
              0.449124157,
              0.494896948,
              0.522058845,
              1
            ]
          },
          "textureProperties": {
            "_MainTex": 5,
            "_ShadeTexture": 5,
            "_SphereAdd": 1
          },
          "keywordMap": {
            "MTOON_OUTLINE_COLORED": true,
            "MTOON_OUTLINE_COLOR_MIXED": true,
            "MTOON_OUTLINE_WIDTH_WORLD": true
          },
          "tagMap": {
            "RenderType": "Opaque"
          }
        },
        {
          "name": "Alicia_hair_trans",
          "shader": "VRM/MToon",
          "renderQueue": 2501,
          "floatProperties": {
            "_Cutoff": 0.493,
            "_BumpScale": 1,
            "_ReceiveShadowRate": 1,
            "_ShadingGradeRate": 1,
            "_ShadeShift": 0,
            "_ShadeToony": 0,
            "_LightColorAttenuation": 0,
            "_IndirectLightIntensity": 0.1,
            "_OutlineWidth": 0.05,
            "_OutlineScaledMaxDistance": 1,
            "_OutlineLightingMix": 1,
            "_DebugMode": 0,
            "_BlendMode": 3,
            "_OutlineWidthMode": 1,
            "_OutlineColorMode": 1,
            "_CullMode": 2,
            "_OutlineCullMode": 1,
            "_SrcBlend": 5,
            "_DstBlend": 10,
            "_ZWrite": 1
          },
          "vectorProperties": {
            "_Color": [
              1,
              1,
              1,
              1
            ],
            "_ShadeColor": [
              1,
              0.779,
              0.7619999,
              1
            ],
            "_MainTex": [
              0,
              0,
              1,
              1
            ],
            "_ShadeTexture": [
              0,
              0,
              1,
              1
            ],
            "_BumpMap": [
              0,
              0,
              1,
              1
            ],
            "_ReceiveShadowTexture": [
              0,
              0,
              1,
              1
            ],
            "_ShadingGradeTexture": [
              0,
              0,
              1,
              1
            ],
            "_SphereAdd": [
              0,
              0,
              1,
              1
            ],
            "_EmissionColor": [
              0,
              0,
              0,
              1
            ],
            "_EmissionMap": [
              0,
              0,
              1,
              1
            ],
            "_OutlineWidthTexture": [
              0,
              0,
              1,
              1
            ],
            "_OutlineColor": [
              0.8039216,
              0.7825373,
              0.742823541,
              1
            ]
          },
          "textureProperties": {
            "_MainTex": 5,
            "_ShadeTexture": 5,
            "_SphereAdd": 1
          },
          "keywordMap": {
            "MTOON_OUTLINE_COLOR_MIXED": true,
            "MTOON_OUTLINE_WIDTH_WORLD": true,
            "_ALPHABLEND_ON": true
          },
          "tagMap": {
            "RenderType": "Transparent"
          }
        },
        {
          "name": "Alicia_other_zwrite",
          "shader": "VRM/MToon",
          "renderQueue": 2501,
          "floatProperties": {
            "_Cutoff": 0.5,
            "_BumpScale": 1,
            "_ReceiveShadowRate": 1,
            "_ShadingGradeRate": 1,
            "_ShadeShift": -0.5,
            "_ShadeToony": 0.9,
            "_LightColorAttenuation": 0,
            "_IndirectLightIntensity": 0.1,
            "_OutlineWidth": 0.601,
            "_OutlineScaledMaxDistance": 1,
            "_OutlineLightingMix": 1,
            "_DebugMode": 0,
            "_BlendMode": 3,
            "_OutlineWidthMode": 0,
            "_OutlineColorMode": 0,
            "_CullMode": 2,
            "_OutlineCullMode": 1,
            "_SrcBlend": 5,
            "_DstBlend": 10,
            "_ZWrite": 1
          },
          "vectorProperties": {
            "_Color": [
              1,
              1,
              1,
              1
            ],
            "_ShadeColor": [
              1,
              0.8666667,
              0.840000033,
              1
            ],
            "_MainTex": [
              0,
              0,
              1,
              1
            ],
            "_ShadeTexture": [
              0,
              0,
              1,
              1
            ],
            "_BumpMap": [
              0,
              0,
              1,
              1
            ],
            "_ReceiveShadowTexture": [
              0,
              0,
              1,
              1
            ],
            "_ShadingGradeTexture": [
              0,
              0,
              1,
              1
            ],
            "_SphereAdd": [
              0,
              0,
              1,
              1
            ],
            "_EmissionColor": [
              0,
              0,
              0,
              1
            ],
            "_EmissionMap": [
              0,
              0,
              1,
              1
            ],
            "_OutlineWidthTexture": [
              0,
              0,
              1,
              1
            ],
            "_OutlineColor": [
              0.449124157,
              0.494896948,
              0.522058845,
              1
            ]
          },
          "textureProperties": {
            "_MainTex": 6,
            "_ShadeTexture": 6
          },
          "keywordMap": {
            "_ALPHABLEND_ON": true
          },
          "tagMap": {
            "RenderType": "Transparent"
          }
        }
      ]
    }
  },
  "extras": {}
}'
));
select * from vrm where json_extract("vrm", '$.asset') is not null;
select json_extract("vrm", '$.nodes') from vrm;

SELECT *
FROM vrm, json_each(json_extract("vrm", '$.nodes'));

SELECT value
FROM vrm, json_each(json_extract("vrm", '$.extensions.VRM.humanoid.humanBones'));

WITH human_bones AS (SELECT value
FROM vrm, json_each(json_extract("vrm", '$.extensions.VRM.humanoid.humanBones')))
        SELECT json_extract(value, '$.bone' ) as name,
     json_extract(value, '$.node' ) as node FROM human_bones;

SELECT key, value
FROM vrm, json_each(json_extract("vrm", '$.extensions.VRM.meta'));

SELECT key, value
FROM vrm, json_each(json_extract("vrm", '$.extensions.VRM.materialProperties'));

WITH material_properties AS (SELECT key, value
FROM vrm, json_each(json_extract("vrm", '$.extensions.VRM.materialProperties')))
SELECT json_extract(material_properties.value, '$.name') as name,
json_extract(material_properties.value, '$.shader') as shader,
json_extract(material_properties.value, '$.renderQueue') as render_queue
FROM material_properties;

WITH float_properties AS (WITH material_properties AS (SELECT key, value
FROM vrm, json_each(json_extract("vrm", '$.extensions.VRM.materialProperties')))
SELECT json_extract(material_properties.value, '$.name') as name,
json_extract(material_properties.value, '$.floatProperties') as float_properties
FROM material_properties)
SELECT name, key
FROM float_properties, json_each(float_properties)
WHERE name = 'Alicia_eye';

WITH float_properties AS (WITH material_properties AS (SELECT key, value
FROM vrm, json_each(json_extract("vrm", '$.extensions.VRM.materialProperties')))
SELECT json_extract(material_properties.value, '$.name') as name,
  	 json_extract(material_properties.value, '$.shader') as shader,
	 json_extract(material_properties.value, '$.renderQueue') as render_queue,
json_extract(material_properties.value, '$.floatProperties') as float_properties,
json_extract(material_properties.value, '$.vectorProperties') as vector_properties,
json_extract(material_properties.value, '$.textureProperties') as texture_properties,
json_extract(material_properties.value, '$.keywordMap') as keyword_map
FROM material_properties)
SELECT name,
     shader,
     render_queue,
     keyword_map,
     -- https://modern-sql.com/feature/filter
     MAX(fp.value) FILTER (WHERE fp.key = '_Cutoff') as cutoff,
     MAX(fp.value) FILTER (WHERE fp.key = '_BumpScale') as bump_scale,
     MAX(fp.value) FILTER (WHERE fp.key = '_ReceiveShadowRate') as recieve_shadow_rate,
     MAX(fp.value) FILTER (WHERE fp.key = '_ShadingGradeRate') as shading_grade_rate,
     MAX(fp.value) FILTER (WHERE fp.key = '_ShadeShift') as shade_shift,
     MAX(fp.value) FILTER (WHERE fp.key = '_ShadeToony') as shade_toony,
     MAX(fp.value) FILTER (WHERE fp.key = '_LightColorAttenuation') as light_color_attenuation,
     MAX(fp.value) FILTER (WHERE fp.key = '_IndirectLightIntensity') as indirect_light_intensity,
     MAX(fp.value) FILTER (WHERE fp.key = '_OutlineWidth') as outline_width,
     MAX(fp.value) FILTER (WHERE fp.key = '_OutlineScaledMaxDistance') as outline_scaled_max_distance,
     MAX(fp.value) FILTER (WHERE fp.key = '_OutlineLightingMix') as outline_lighting_mix,
     MAX(fp.value) FILTER (WHERE fp.key = '_DebugMode') as debug_mode,
     MAX(fp.value) FILTER (WHERE fp.key = '_BlendMode') as blend_mode,
     MAX(fp.value) FILTER (WHERE fp.key = '_OutlineWidthMode') as outline_width_mode,
     MAX(fp.value) FILTER (WHERE fp.key = '_OutlineColorMode') as outline_color_mode,
     MAX(fp.value) FILTER (WHERE fp.key = '_CullMode') as cull_mode,
     MAX(fp.value) FILTER (WHERE fp.key = '_SrcBlend') as src_blend,
     MAX(fp.value) FILTER (WHERE fp.key = '_DstBlend') as dst_blend,
     MAX(fp.value) FILTER (WHERE fp.key = '_ZWrite') as z_write,
     MAX(vp.value) FILTER (WHERE vp.key = '_Color') as color,
     MAX(vp.value) FILTER (WHERE vp.key = '_ShadeColor') as shade_color,
     MAX(vp.value) FILTER (WHERE vp.key = '_MainTex') as main_tex,
     MAX(vp.value) FILTER (WHERE vp.key = '_ShadeTexture') as shade_texture,
     MAX(vp.value) FILTER (WHERE vp.key = '_BumpMap') as bump_map,
     MAX(vp.value) FILTER (WHERE vp.key = '_ReceiveShadowTexture') as receive_shadow_texture,
     MAX(vp.value) FILTER (WHERE vp.key = '_ShadingGradeTexture') as shading_grade_texture,
     MAX(vp.value) FILTER (WHERE vp.key = '_SphereAdd') as sphere_add,
     MAX(vp.value) FILTER (WHERE vp.key = '_EmissionColor') as emission_color,
     MAX(vp.value) FILTER (WHERE vp.key = '_EmissionMap') as emission_map,
     MAX(vp.value) FILTER (WHERE vp.key = '_OutlineWidthTexture') as outline_width_texture,
     MAX(vp.value) FILTER (WHERE vp.key = '_OutlineColor') as outline_color,
     MAX(tp.value) FILTER (WHERE tp.key = '_MainTex') as main_tex,
     MAX(tp.value) FILTER (WHERE tp.key = '_ShadeTexture') as shade_texture,
     MAX(tp.value) FILTER (WHERE tp.key = '_SphereAdd') as sphere_add
FROM float_properties, json_each(float_properties) as fp, json_each(vector_properties) as vp
, json_each(texture_properties) as tp, json_each(keyword_map) as km
GROUP BY name;
