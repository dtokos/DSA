#import <XCTest/XCTest.h>
#include "ht.hpp"
#include "jrht.hpp"

int htNumbers[1000] = {
	139, 347, 986, 65, 38, 40, 700, 849, 24, 599, 371, 323, 621, 679, 537, 762, 585, 697, 822, 817, 894, 558, 45, 343, 157, 474, 403, 641, 222, 284, 399, 788, 433, 564, 174, 330, 658, 974, 488, 152, 247, 175, 739, 741, 63, 153, 797, 17, 35, 714, 992, 672, 346, 405, 93, 184, 848, 369, 163, 706, 182, 329, 539, 398, 836, 862, 430, 501, 419, 895, 889, 87, 559, 372, 845, 808, 543, 771, 395, 729, 211, 975, 99, 528, 503, 455, 397, 713, 552, 165, 584, 28, 327, 711, 198, 852, 499, 803, 674, 980, 663, 176, 660, 994, 463, 544, 952, 52, 653, 61, 796, 880, 907, 756, 613, 469, 318, 569, 841, 777, 155, 394, 916, 359, 731, 414, 84, 810, 618, 514, 77, 477, 767, 435, 151, 661, 489, 888, 540, 353, 893, 420, 718, 18, 946, 724, 307, 884, 795, 764, 429, 129, 238, 351, 482, 766, 924, 121, 928, 215, 582, 138, 302, 867, 567, 750, 872, 912, 534, 112, 206, 685, 877, 636, 148, 998, 801, 964, 902, 27, 384, 291, 689, 984, 934, 442, 968, 56, 600, 30, 147, 191, 871, 431, 709, 547, 651, 627, 12, 864, 511, 13, 253, 596, 966, 919, 101, 899, 529, 710, 507, 938, 205, 970, 891, 939, 368, 326, 379, 71, 800, 765, 490, 533, 649, 31, 940, 480, 646, 103, 686, 261, 758, 615, 8, 275, 26, 913, 971, 773, 67, 178, 949, 633, 113, 491, 127, 352, 213, 381, 656, 882, 149, 704, 321, 298, 170, 612, 987, 595, 639, 805, 230, 897, 798, 863, 365, 132, 19, 167, 344, 289, 598, 270, 402, 892, 553, 535, 317, 640, 193, 229, 288, 842, 963, 237, 643, 130, 286, 821, 187, 457, 614, 782, 622, 628, 549, 995, 575, 727, 78, 6, 755, 524, 487, 563, 89, 255, 866, 715, 42, 299, 186, 410, 55, 417, 538, 141, 448, 240, 216, 873, 485, 754, 357, 965, 579, 532, 1, 242, 830, 886, 181, 114, 172, 927, 54, 450, 350, 753, 338, 60, 838, 811, 815, 470, 495, 684, 197, 601, 465, 667, 637, 983, 580, 820, 740, 647, 834, 223, 227, 281, 23, 126, 565, 248, 438, 464, 425, 111, 623, 304, 611, 900, 578, 160, 609, 436, 276, 66, 682, 259, 953, 749, 264, 401, 860, 976, 325, 305, 573, 770, 737, 202, 979, 70, 360, 280, 33, 785, 745, 207, 678, 812, 945, 57, 428, 930, 948, 82, 219, 648, 982, 80, 936, 676, 791, 717, 769, 523, 542, 427, 144, 44, 361, 608, 252, 74, 116, 835, 969, 696, 898, 283, 657, 421, 51, 454, 625, 950, 935, 654, 484, 794, 336, 695, 751, 918, 453, 341, 752, 550, 224, 847, 662, 508, 96, 993, 839, 158, 481, 829, 588, 638, 459, 850, 645, 303, 171, 200, 308, 530, 451, 391, 521, 339, 440, 362, 98, 319, 88, 443, 819, 510, 772, 807, 203, 826, 978, 220, 312, 475, 527, 209, 199, 415, 732, 911, 806, 334, 349, 568, 164, 447, 505, 673, 562, 551, 358, 449, 587, 446, 757, 386, 256, 295, 989, 218, 923, 389, 570, 813, 118, 707, 607, 180, 39, 712, 937, 225, 46, 957, 105, 885, 502, 20, 43, 467, 356, 125, 917, 789, 69, 694, 943, 73, 2, 472, 493, 597, 632, 37, 603, 761, 383, 944, 545, 374, 36, 140, 86, 439, 996, 62, 655, 577, 526, 314, 316, 226, 581, 277, 920, 728, 29, 83, 516, 437, 426, 16, 250, 76, 592, 268, 652, 483, 733, 387, 106, 287, 814, 571, 914, 444, 790, 743, 904, 456, 972, 134, 680, 604, 244, 665, 262, 831, 629, 320, 110, 802, 999, 345, 500, 466, 3, 21, 669, 376, 901, 691, 775, 478, 763, 142, 10, 95, 876, 342, 396, 825, 497, 290, 119, 843, 434, 855, 909, 258, 910, 468, 861, 804, 522, 818, 92, 881, 404, 363, 332, 779, 840, 58, 933, 890, 687, 681, 719, 512, 75, 738, 272, 122, 630, 967, 925, 870, 868, 479, 269, 951, 108, 921, 677, 333, 297, 234, 432, 560, 666, 50, 471, 335, 869, 591, 49, 509, 296, 990, 887, 370, 378, 747, 406, 143, 541, 824, 313, 400, 41, 693, 958, 619, 605, 513, 668, 650, 311, 34, 90, 423, 441, 786, 776, 874, 955, 959, 932, 702, 131, 985, 557, 746, 235, 941, 492, 671, 107, 875, 72, 322, 809, 748, 117, 574, 906, 705, 531, 309, 520, 47, 905, 878, 25, 589, 236, 195, 64, 94, 173, 208, 760, 214, 833, 104, 896, 212, 292, 961, 91, 832, 128, 504, 606, 675, 926, 556, 460, 844, 271, 294, 962, 566, 210, 716, 642, 548, 698, 742, 536, 14, 988, 960, 257, 546, 721, 699, 659, 231, 859, 246, 409, 407, 254, 515, 774, 486, 373, 973, 124, 68, 15, 799, 954, 366, 392, 572, 81, 48, 759, 854, 9, 137, 328, 783, 278, 263, 644, 690, 120, 555, 393, 340, 161, 265, 388, 734, 169, 179, 150, 282, 956, 879, 590, 991, 865, 496, 858, 221, 823, 249, 189, 602, 177, 315, 828, 857, 375, 494, 306, 778, 720, 166, 620, 324, 377, 683, 228, 245, 688, 722, 517, 243, 241, 266, 445, 594, 730, 631, 473, 109, 616, 337, 100, 190, 635, 239, 908, 929, 561, 192, 267, 418, 981, 408, 554, 816, 997, 59, 251, 664, 32, 97, 692, 390, 458, 708, 196, 915, 519, 634, 382, 883, 781, 725, 416, 183, 518, 136, 735, 7, 617, 736, 922, 726, 768, 412, 364, 354, 380, 851, 413, 194, 102, 703, 846, 583, 285, 145, 787, 792, 260, 856, 853, 784, 133, 159, 115, 422, 947, 11, 168, 793, 201, 780, 525, 146, 293, 593, 744, 1000, 204, 232, 576, 903, 498, 310, 586, 424, 461, 931, 610, 301, 367, 185, 452, 723, 355, 942, 626, 462, 154, 162, 4, 300, 273, 135, 837, 22, 188, 827, 331, 217, 274, 5, 977, 79, 123, 670, 476, 53, 624, 348, 385, 85, 156, 701, 279, 233, 506, 411,
};

@interface TestHTPerformance : XCTestCase

@end

@implementation TestHTPerformance

- (void)testHTInsertPerformance {
	[self measureBlock:^{
		HashTable *table = htMake();
		
		for (int i = 0; i < 1000; i++)
			htInsert(table, htNumbers[i], htNumbers[i]);
	}];
}

- (void)testHTSearchPerformance {
	HashTable *table = htMake();
	for (int i = 0; i < 1000; i++)
		htInsert(table, htNumbers[i], htNumbers[i]);
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++)
			htSearch(table, htNumbers[i]);
	}];
}

- (void)testJRHTInsertPerformance {
	[self measureBlock:^{
		ht_hash_table *table = ht_new();
		char key[12];
		
		for (int i = 0; i < 1000; i++) {
			sprintf(key, "%d", htNumbers[i]);
			ht_insert(table, key, key);
		}
	}];
}

- (void)testJRHTSearchPerformance {
	ht_hash_table *table = ht_new();
	char keyBuffer[12], *key = keyBuffer;
	for (int i = 0; i < 1000; i++) {
		sprintf(key, "%d", htNumbers[i]);
		ht_insert(table, key, key);
	}
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++) {
			sprintf(key, "%d", htNumbers[i]);
			ht_search(table, key);
		}
	}];
}

@end