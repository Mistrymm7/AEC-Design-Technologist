// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "MMCppActor.generated.h"

UCLASS()
class IXVS_API AMMCppActor : public AActor
{
	GENERATED_BODY()
	
public:	
	// Sets default values for this actor's properties
	AMMCppActor();

	//Property that affects damaage
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
		int32 TotalDamage;

	//Property that affects damaage
	UPROPERTY(EditAnywhere, BlueprintReadOnly)
		int32 HealPower;

	UFUNCTION(BlueprintCallable)
		int32 DamageDetector(int32 value);

protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;

public:	
	// Called every frame
	virtual void Tick(float DeltaTime) override;

private:
	//UPROPERTY(BlueprintReadWrite, meta = (AllowPrivateAccess) = 'true')
		//float Health = 100.f;

};
