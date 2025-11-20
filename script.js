document.addEventListener("DOMContentLoaded", function () {
  const categorySelectId = "00NWC000004Mh7F";
  const typeSelectId = "00NWC000004MfyH";

  const categorySelect = document.getElementById(categorySelectId);
  const typeSelect = document.getElementById(typeSelectId);

  // Map Categories to Types
  const serviceOptions = {
    "Bearing Repack": [
      { val: "Tandem Axle", text: "Tandem Axle" },
      { val: "Triple Axle", text: "Triple Axle" },
    ],
    "Suspension Upgrade": [
      { val: "Roadmaster Comfort Ride", text: "Roadmaster Comfort Ride" },
      {
        val: "Lippert Center-Point Air Ride System",
        text: "Lippert Center-Point Air Ride",
      },
      { val: "CRE 3000 (MORyde)", text: "CRE 3000 (MORryde)" },
      { val: "AllTrek 4000 (MORryde)", text: "AllTrek 4000 (MORryde)" },
      {
        val: "Heavy Duty Shackle and Wet Bolt Kit (MORryde)",
        text: "Heavy Duty Shackle & Wet Bolt Kit",
      },
      { val: "Crossmember (MORryde)", text: "Crossmember (MORryde)" },
      { val: "Unsure", text: "Unsure / Need Advice" },
    ],
    "Disc Brake Upgrade": [
      { val: "DeeMaxx", text: "DeeMaxx" },
      { val: "Kodiak", text: "Kodiak" },
      { val: "Disc Brake Upgrade - Unsure", text: "Unsure / Need Advice" },
    ],
    "Additional Safety Products": [
      { val: "Hubsavers", text: "Hubsavers" },
      { val: "Solid Steel Lugnuts", text: "Solid Steel Lugnuts" },
    ],
  };

  if (categorySelect && typeSelect) {
    categorySelect.addEventListener("change", function () {
      updateServiceTypes(categorySelect, typeSelect, serviceOptions);
    });
  }

  function updateServiceTypes(catSelect, typSelect, optionsMap) {
    // 1. Get ALL selected options from the Category list
    const selectedOptions = Array.from(catSelect.selectedOptions);

    // 2. Clear the Type list
    typSelect.innerHTML = "";

    let hasValidSelections = false;

    // 3. Loop through selected categories
    if (selectedOptions.length > 0) {
      selectedOptions.forEach((option) => {
        const categoryName = option.value;

        // If this category has mapped types, create a Group for it
        if (optionsMap[categoryName]) {
          hasValidSelections = true;

          // Create <optgroup> (Header for the category)
          const group = document.createElement("optgroup");
          group.label = categoryName;

          // Add the specific types to this group
          optionsMap[categoryName].forEach((opt) => {
            const newOption = document.createElement("option");
            newOption.value = opt.val;
            newOption.text = opt.text;
            group.appendChild(newOption);
          });

          typSelect.appendChild(group);
        }
      });
    }

    // 4. Manage State (Enable/Disable)
    if (hasValidSelections) {
      typSelect.disabled = false;
    } else {
      // If user selected "Other" or nothing that has sub-types
      typSelect.disabled = true;
      const defaultOption = document.createElement("option");
      if (selectedOptions.length === 0) {
        defaultOption.text = "-- Select Categories First --";
      } else {
        defaultOption.text = "No subtypes for selection";
      }
      typSelect.appendChild(defaultOption);
    }
  }
});
