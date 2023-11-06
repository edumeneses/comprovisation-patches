# Edu Meneses - comprovisation patches

This repository contains a collection of patches used for comprovisation (see Dumas, 2010, for a complete definition of the term) using digital and augmented musical instruments.

All Pure Data patches and SuperCollider code shared were used in performances and jam sessions related to my performance and research.
More info can be found at [https://www.edumeneses.com/](https://www.edumeneses.com/).

## TimeMachine

TimeMachine is a comprovisation piece using the latest version of the [GuitarAMI](https://github.com/Puara/GuitarAMI) developed at [IDMIL](https://www.idmil.org) and [CIRMMT](https://www.cirmmt.org/en) between 2017 and 2020. [Version 1](/TimeMachine(v1).pd) is built in Pure Data and contains only the FFT-based Freeze and time-stretching capabilities of the augmented guitar. [Version 2](/TimeMachine(v2).scd) includes all capabilities presented in this [small demo](https://youtu.be/vmC-K1rUBt8?si=9VxCu0_BfYGtCdqH) and it was used for *Stretching nylon*, a free improvisation for GuitarAMI and guiaRT (tro augmented guitars).

![TimeMachine_PD](/images/TimeMachine_PD.png "TIme Machine PD patch.")

## GuitarAMI

[GuitarAMI_0.96](/GuitarAMI_0.96.scd) and [GuitarAMI_0.1.1](/GuitarAMI_0.1.1.pd) are two patches made in SuperCollider and Pure Data for the GuitarAMI. They were used for the [live@CIRMMT Mini-Festival](https://www.youtube.com/playlist?list=PLtZA_ldhdqWImLgeyv2Fm_m4GMTHZuRNk) pieces The Turing Test (Alex Burtzos) and Insomnia Rain (Derek Cooper).

## Experimentos (series)

[Experimentos](/Experimentos_series/) are a series of comprovisation pieces using the first GuitarAMI prototypes from 2013 to 2015. The latest version (v.0.6) was used for the piece **Improviso em Três Dimensões**, (Improvisation in 3 Dimensions) for the B.E.A.T. (Brazilian Electronic Aleatorium Trio), which premiered in June 2015 (Campinas, Brazil).

![Experimentos_0.6](/images/experimentos_0.6.png "Experimentos v0.6 running on PlugData.")

The original patches require [PdExtended](https://puredata.info/downloads/pd-extended) to run. Version 0.6 was updated to run using [PlugData](), although it requires some externals to work: comport, cyclone, extra, moocow, and zexy.

## Caixinha de fósforo (Matchbox)

[MatchBox](/Matchbox/) is a Pure Data patch created for a comprovisation patch of the same name. The piece plays with the traditional use of everyday objects in traditional brazilian music (rodas de samba). Matchboxes, similar to forks/knives, plates or cups, are among objects commonly found in cafés and bars that could be incorporated to samba improvisation sessions as percussion instruments.

![Matchbox_Android](/images/matchbox.png "Matchbox patch running on an Android phone.")

The patch uses [MobMuPlat](https://danieliglesia.com/mobmuplat/), by Daniel Iglesia, to embed the patch into Android smartphones and digitally emulate a matchbox. Movement data can also be used to control other performance parameters if they are available (e.g., tape speed or lights).

## MPU demos

[This folder](/MPU_demos/) contains demos for embedding DSP into [the MPU](https://github.com/Puara/MPU). Most features were used in workshops and immersive spaces at [SAT](https://sat.qc.ca/).

## Auxiliary folders

[PD abstractions](/PD_abstractions/) and [common](/common/) are auxiliary folders with subpatches and SC abstractions used as building blocks to create comprovisation pieces or set digital instruments for a particular improvisation session.

## References

[Dudas, Richard; “Comprovisation”: The Various Facets of Composed Improvisation within Interactive Performance Systems. Leonardo Music Journal 2010; 20 29–31. doi: https://doi.org/10.1162/LMJ_a_00009](https://www.jstor.org/stable/40926370).