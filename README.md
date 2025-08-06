# NextMegaHit

Lightweight Nextflow script for running Megahit and generating a report with multiQC. 
Runs megahit on paired read illumina samples from metagenomic samples. 

By default the workflow runs megahit with the `meta-large` configuration. 

Please use the issues tab to report issues/request features. 

## How to run. 

### Apptainer

#### Prerequisites

- Nextflow (can be easily installed with mamba/conda, and executed from there.)
- Apptainer (original opensource fork of Singularity)
apptainer functionality can be quickly assessed with the following command:

``` bash 
apptainer run library://sylabsed/examples/lolcow
```
#### Installation

Clone this repository onto the machine where the pipeline is to be run. 


#### Running the workflow

To run NextMegaHit; enter the base directory and run with the following command:

``` bash
nextflow run main.nf <flags/parameters>
```

Parameters cab be suppllied in two ways, either by updating the params file with required params or by supplying the params as flags in the CLI.

The only parameter that NextMegaHit requires is the inputs parameter. This is the directory containing your paired end reads. 

>Note: this also needs the operators for identifying and matching the paired end reads. 
> e.g for the following dir of two sets of pair end reads:
> ``` 
>reads/first_read_1.fq.gz
>reads/first_read_2.fq.gz
>reads/second_read_1.fq.gz
>reads/second_read_2.fq.gz
>```
> Would be supplied as:
> ```
>"reads/*read_{1,2}.fq.gz"
> ```
>Nextflow can then group the reads by the first/second and supply both reads to the process. See the [Nextflow documentation](https://www.nextflow.io/docs/latest/reference/channel.html#fromfilepairs) for more information.


This can be supplied with the following flags:

``` bash
nextflow run main.nf -input "reads/*read_{1,2}.fq.gz"
```
or adding to the params file as:

``` json 
#params.json

input = "reads/*read_{1,2}.fq.gz"
```
This can be run with the following command:
``` bash 
nextflow run main.nf
```



### Conda

WIP

## Useful flags/parameters

### Required

```
- input  # This is the directory with your paired end reads.
```

### Optional

```
General nextflow flags:
--resume  # Allows resumption of workflow from most recently cached 
```

## TODO.

- [ ] Create a sensible test dataset. For easy user validation. 
- [ ] Singularity and conda profiles.
- [ ] Automatic contig graph construction to `.svg` or `.png` figures. 
- [ ] Add optional workflows for different MegaHit flags. 
- [ ] Add different CPU options.
- [ ] SLURM support configuration. 

