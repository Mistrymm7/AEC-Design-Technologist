// Fill out your copyright notice in the Description page of Project Settings.


#include "MMCppActor.h"

// Sets default values
AMMCppActor::AMMCppActor()
{
 	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;

	TotalDamage = 5;

	DamageDetector(14);

}

// Called when the game starts or when spawned
void AMMCppActor::BeginPlay()
{
	Super::BeginPlay();

	// Standard way to log to console.
	UE_LOG(LogTemp, Warning, TEXT("I just started running"));

	// Log to Screen
	GEngine->AddOnScreenDebugMessage(-1, 5.f, FColor::Red, TEXT("Screen Message"));
	
}

 int32 AMMCppActor::DamageDetector(int32 value)
{
	TotalDamage = value; 

	return TotalDamage;

}

// Called every frame
void AMMCppActor::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);

}

