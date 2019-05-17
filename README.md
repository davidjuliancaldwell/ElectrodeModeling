# Code to look for evoked potentials in variable spacing stimulation data as well as fit analytic models to the volume conducted signals

This repository contains code to analyze human intracranial datasets from the stimulation spacing and stimulation geometry projects.

---
### To analyze the volume conducted signals:

To fit the analytic models from 8 subjects as discussed in David Caldwell's thesis, the following master scripts are useful:  ***calculate_spherical_patient.m*** in ElectrodeModeling/manuscript/spherical_model as well as
***calculate_spherical_patient_3ada8b.m*** in ElectrodeModeling/manuscript/spherical_model

---

### To analyze evoked potentials:

An example workflow is shown for Subject ID ***010dcb***

running ***ep_search_iterate.m*** as setup will create the data files for 010dcb, which can then be fed into ***analyze_010dcb.m*** which illustrates how once the data has been extracted into a chunked form, the peak to peak voltages can be calculated. Plots are also made showing the stimulation artifact in ***ep_search_iterate.m***, as well as the evoked potentials in ***analyze_010dcb.m****

---
A link to a large amount of the compiled human ECoG and DBS data is below

https://drive.google.com/open?id=1j\_J7ncKy4aAgdwGUmLxid6NIPJ8\_Eytz

---

David J Caldwell, BSD-3 License
