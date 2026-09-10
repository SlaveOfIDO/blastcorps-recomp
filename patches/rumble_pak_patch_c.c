#include "patches.h"

#define osMotorInit osMotorInit_recomp

extern s32 osMotorInit(OSMesgQueue*, OSPfs*, int);
extern OSMesgQueue gSerialEventQueue;

OSPfs gControllerMotor[4] = { 0 };

void Hook_Rumble_Init(void) {
    s32 i;

    for (i = 0; i < 4; i++) {
        osMotorInit(&gSerialEventQueue, &gControllerMotor[i], i);
        gControllerMotor[i].status = PFS_MOTOR_INITIALIZED;
        // recomp_printf("Initialized Motor %d: Address %x \n", i, &gControllerMotor[i]);
    }
}