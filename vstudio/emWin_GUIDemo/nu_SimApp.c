#include "nu_SimApp.h"
#include "LCD_SIM.h"

NUSIMAPI int CALLBACK AppMain(void)
{
	main();
	//MainTask();
	return 0;
}

NUSIMAPI void CALLBACK NUSIM_GUI_Enable()
{
	SIM_GUI_Enable();
}

NUSIMAPI char* CALLBACK NUSIM_LCD_Init()
{
	return LCDSIM_Init();
}

NUSIMAPI void CALLBACK NUSIM_LCD_Exit()
{
	LCDSIM_Exit();
}

NUSIMAPI void CALLBACK  NUSIM_SetMouseState(int x, int y, int KeyStat, int LayerIndex)
{
	LCDSIM_SetMouseState(x, y, KeyStat, LayerIndex);
}

NUSIMAPI void CALLBACK  NUSIM_CheckMouseState(int LayerIndex)
{
	LCDSIM_CheckMouseState(LayerIndex);
}

NUSIMAPI int CALLBACK NUSIM_GetXSize(void)
{
	return LCD_GetXSize();
}

NUSIMAPI int CALLBACK NUSIM_GetYSize(void)
{
	return LCD_GetYSize();
}
