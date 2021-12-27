# Computer-Arch-Lab-3

This is a report regarding the findings of the third Part of the Computer Architecture Course Lab of Aristotle University in Thessaloniki.

During this part we had the opportunity to familiarize ourselves with *mcPat*, a simulator which can provide analytic feedback concerning the __power consumption__ , __harware area space__ and __system timing__, of a given archtecture model. Let's take a dive to this useful tool:

1. *McPAT's* original ***validation report*** was published in *December 12th, 2009* . The validations process aimed to testfy for the accuracy and fidelity of the tool's results by comparing a series of processors' published data regarding power and area, provided the timing of each inivudual system, to the respective data extracted from McPAT. The processor models used in this process were:

* 90nm ***Niagara*** processor running at __1.2GHz__ with a __1.2V__ power supply
* 65nm ***Niagara2*** processor running at __1.4GHz__ with a __1.1V__ power supply
* 65nm ***Xeon*** processor running at __3.4GHz__ with a __1.25V__ power supply
* 180nm ***Alpha 21364*** processor running at __1.2GHz__ with a __1.5V__ power supply

This comparison's results were definitely in McPAT's favor, as all extracted data had minimal differences from the original data.

!(McPAT Validations results) [mcpat_vlaidation_results]