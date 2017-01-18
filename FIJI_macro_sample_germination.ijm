
//this is the header for the results
header = "Lot & Time\t Volume (mm^3)\t Surface (mm^2)\t Nb of obj. voxels\t Nb of surf. voxels\t IntDen\t Mean\t StdDev\t Median\t Min\t Max\t X\t Y\t Z\t Mean dist. to surf. (mm)\t SD dist. to surf. (mm)\t Median dist. to surf. (mm)\t XM\t YM\t ZM\t BX\t BY\t BZ\t B-width\t B-height\t B-depth\t Time\t Seed No\t ERR No Seed\t THE SAME SEED AT THE\t Lot & Time\t Volume (mm^3)\t Surface (mm^2)\t Nb of obj. voxels\t Nb of surf. voxels\t IntDen\t Mean\t StdDev\t Median\t Min\t Max\t X\t Y\t Z\t Mean dist. to surf. (mm)\t SD dist. to surf. (mm)\t Median dist. to surf. (mm)\t XM\t YM\t ZM\t BX\t BY\t BZ\t B-width\t B-height\t B-depth\t Time\t Seed No\t ERR No Seed\t SubtractStart\t Conf of germ\t DevStrt\t Conf of Germ\t in bits G\t Was last time\n";
misso = 0;
miss= 0;
germlist = "G-";

list = getFileList(input);

run("Set Scale...", "distance=1452 known=50 pixel=1 unit=mm global");
run("HSB Stack");
makeRectangle(320, 380, 2652, 2132);
run("Crop");
// Threshold
run("Stack to Images");
selectWindow("Saturation");
setThreshold(0, 82);
run("Convert to Mask");
selectWindow("Brightness");
run("Close");
selectWindow("Hue");
setThreshold(0, 140);
run("Convert to Mask");
imageCalculator("Add", "Hue","Saturation");
selectWindow("Saturation");
run("Close");

selectWindow("Hue");
run("Erode");
run("Dilate");

//get total no of seeds to check
run("Analyze Particles...", "size=1-Infinity circularity=0.00-1.00 show=Nothing clear add");
roiManager("Show All with labels");
roiManager("Show All");

//main Section
for (i = i; i<list.length; i++) {													
	path = input+list[i];
	open(path);
															
	name = File.nameWithoutExtension;
	t = t + 1;
	makeRectangle(320, 380, 2652, 2132);
	run("Crop");
	saveAs("Tiff", output+"Seedlot"+Lotno+"_t"+t+"_Croped");

	run("Select All");
	run("Copy");
	run("Internal Clipboard");
	selectImage("Clipboard");
	// Threshold
	run("RGB Stack");
	run("Stack to RGB");
	run("8-bit");
	selectWindow("Clipboard");
	run("Stack to Images");
	selectImage(1);
	run("Select None");
	run("HSB Stack");
	run("Stack to Images");
	selectWindow("Clipboard-1");
	run("Color Transformer", "colour=HSL");
	run("Stack to Images");
	selectWindow("S");
	selectWindow("L");
	selectWindow("H");
	setThreshold(0.36, 0.83);
	run("Convert to Mask");
	run("Invert");
	selectWindow("Clipboard-1");
	// Can remove L section if no light reflections on any seeds
	// Saturation Threshold
	selectWindow("Saturation");
	setThreshold(0, 100);
	run("Convert to Mask");
	// Green Threshold
	selectWindow("Green");
	setThreshold(185, 255);
	run("Convert to Mask");
	// Red Threshold
	selectWindow("Red");
	setThreshold(150, 255);
	run("Convert to Mask");
	// Hue Threshold
	selectWindow("Hue");
	setThreshold(0, 145);
	run("Convert to Mask");

	// Calculate Final Image
	imageCalculator("OR", "Saturation","Red");
	imageCalculator("OR", "Green","Saturation");
	imageCalculator("AND", "Red","H");
	selectWindow("Red");
	run("Dilate");
	// remove reflections
	imageCalculator("Subtract", "Green","Red");
	imageCalculator("OR", "Hue","Green");

	//hole filling
	selectWindow("Hue");
	run("Dilate");
	run("Erode");
	imageCalculator("AND", "Hue","Clipboard (RGB)");
	
	// Subscript to (Close all images) //
	
	// For each seed
	for(s = 0; s < LotROIno; s++){
		open(...); // open previously saved seed image
		roiManager(...); // get areas of interest
		run("Crop");
		
		run("3D Objects Counter", "threshold=2 slice=0 min.=450 max.=43200 objects statistics");
		
		selectWindow("Statistics for seed"+s+"_lot"+Lotno+"_t"+t+"_threshold.tif");	
		IJ.renameResults("Results");

		// Get the results form the object analysis
		selectWindow("Results"); 
		text = getInfo(); 
		lines = split(text, "\n"); 
		columns = split(lines[0], "\t"); 
		noL = lines.length;
		noL = noL - 1;
		row = ""; 
		
		if (noL == 0) {
			"Seed not found" // in all
		}
			
		if (noL > 0) {
			res0 = getResult(columns[0]);
			res1 = getResult(columns[1]);
			res2 = getResult(columns[2]);
			res3 = getResult(columns[3]);
			res4 = getResult(columns[4]);
			res5 = getResult(columns[5]);
			res6 = getResult(columns[6]);
			res7 = getResult(columns[7]);
			res8 = getResult(columns[8]);
			res9 = getResult(columns[9]);
			res10 = getResult(columns[10]);
			res11 = getResult(columns[11]);
			res12 = getResult(columns[12]);
			res13 = getResult(columns[13]);
			res14 = getResult(columns[14]);
			res15 = getResult(columns[15]);
			res16 = getResult(columns[16]);
			res17 = getResult(columns[17]);
			res18 = getResult(columns[18]);
			res19 = getResult(columns[19]);
			res20 = getResult(columns[20]);
			res21 = getResult(columns[21]);
			res22 = getResult(columns[22]);
			res23 = getResult(columns[23]);
			res24 = getResult(columns[24]);
			res25 = getResult(columns[25]);
		}
		row = row + name + "\t";
		row = row + res1 + "\t"; 
		row = row + res2 + "\t"; 
		row = row + res3 + "\t"; 
		row = row + res4 + "\t";
		row = row + res5 + "\t"; 
		row = row + res6 + "\t"; 
		row = row + res7 + "\t"; 
		row = row + res8 + "\t"; 
		row = row + res9 + "\t";
		row = row + res10 + "\t"; 
		row = row + res11 + "\t"; 
		row = row + res12 + "\t"; 
		row = row + res13 + "\t"; 
		row = row + res14 + "\t";
		row = row + res15 + "\t"; 
		row = row + res16 + "\t"; 
		row = row + res17 + "\t"; 
		row = row + res18 + "\t"; 
		row = row + res19 + "\t";
		row = row + res20 + "\t"; 
		row = row + res21 + "\t"; 
		row = row + res22 + "\t"; 
		row = row + res23 + "\t"; 
		row = row + res24 + "\t";
		row = row + res25 + "\t";
		row = row + t + "\t";
		row = row + s + "\t";
		row = row + noL + "\t";
		row = row + "START" + "\t";

		//key vereables Start
		SSA = res2 + 0;
		SNoVo = res4 + 0;
		SIntDen = res5 + 0;
		SMean = res6 + 0;
		SStDev = res7 + 0;
		SMeed = res8 + 0;
		SMax = res10 + 0;
		SMeanDist = res14 + 0;
		SSDDist = res15 + 0;
		SMeedDist =res16 + 0;
		SBW = res23 + 0;
		SBH = res24 + 0;

		//key vereables Mines calculat
		mSA = FSA - SSA;
		mNoVo = FNoVo - SNoVo;
		mIntDen = FIntDen - SIntDen;
		mMean = FMean - SMean;
		mStDev = FStDev - SStDev;
		mMeed = FMeed - SMeed;
		mMax = FMax - SMax;
		mMeanDist = FMeanDist - SMeanDist;
		mSDDist = FSDDist - SSDDist;
		mMeedDist = FMeedDist - SMeedDist;
		mBW = FBW - SBW;
		mBH = FBH - SBH;
		MiunGY = 0;


		// Successive Thresholds leading to a score
		if (mSA > 1.4208) {
			MiunGY = MiunGY + 1;
		}
			if (mNoVo > 99) {
				MiunGY = MiunGY + 1;
			}
				if (mIntDen > 172082) {
					MiunGY = MiunGY + 1;
				}
					if (mMean > 39.0048) {
						MiunGY = MiunGY + 1;
					}
						if (mStDev > 10.7855) {
							MiunGY = MiunGY + 1;
						}
							if (mMeed > 45) {
								MiunGY = MiunGY + 1;
							}
								if (mMax > 36) {
									MiunGY = MiunGY + 1;
								}
									if (mMeanDist > 0.238) {
										MiunGY = MiunGY + 1;
									}
										if (mSDDist > 0.227) {
											MiunGY = MiunGY + 1;
										}
											if (mMeedDist > 0.2142) {
												MiunGY = MiunGY + 1;
											}
												if (mBW > 20) {
													MiunGY = MiunGY + 1;
												}
													if (mBH > 22) {
														MiunGY = MiunGY + 1;	
													}
		// This is repeated for the % change method
		// Results are saved to the table
	}
	// After all seeds are done the table was saved as a .csv file
		
} // End
