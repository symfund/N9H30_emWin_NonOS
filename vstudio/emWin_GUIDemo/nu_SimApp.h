#if !defined (__NU_SIMAPP_H__)
#define __NU_SIMAPP_H__

#ifdef  __cplusplus
extern "C" {
#endif

#define CALLBACK __stdcall

# if defined (_WINDLL)
#   define NUSIMAPI __declspec(dllexport)
# else
#   define NUSIMAPI __declspec(dllimport)
# endif

NUSIMAPI int CALLBACK AppMain(void);
NUSIMAPI void CALLBACK NUSIM_GUI_Enable();
NUSIMAPI char* CALLBACK NUSIM_LCD_Init();
NUSIMAPI void CALLBACK NUSIM_LCD_Exit();
NUSIMAPI void CALLBACK NUSIM_SetMouseState(int x, int y, int KeyStat, int LayerIndex);
NUSIMAPI void CALLBACK NUSIM_CheckMouseState(int LayerIndex);
NUSIMAPI int CALLBACK NUSIM_GetXSize(void);
NUSIMAPI int CALLBACK NUSIM_GetYSize(void);

#ifdef  __cplusplus
}
#endif

#endif