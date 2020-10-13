//
// This is only a SKELETON file for the 'RNA Transcription' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const toRna = (rna_sequence) => {
  const mappings = { 'G': 'C', 'C': 'G', 'T': 'A', 'A': 'U' }
  return rna_sequence.split('').map(nucleotide => mappings[nucleotide]).join('');
};
