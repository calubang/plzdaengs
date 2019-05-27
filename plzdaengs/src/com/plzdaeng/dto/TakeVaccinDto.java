package com.plzdaeng.dto;

public class TakeVaccinDto {
	private PetDto petDto;
	private VaccinationDto vaccinationDto;
	
	public TakeVaccinDto() {
		super();
	}
	
	public PetDto getPetDto() {
		return petDto;
	}
	public void setPetDto(PetDto petDto) {
		this.petDto = petDto;
	}
	public VaccinationDto getVaccinationDto() {
		return vaccinationDto;
	}
	public void setVaccinationDto(VaccinationDto vaccinationDto) {
		this.vaccinationDto = vaccinationDto;
	}

	@Override
	public String toString() {
		return "TakeVaccinDto [petDto=" + petDto + ", vaccinationDto=" + vaccinationDto + "]";
	}
	
}
